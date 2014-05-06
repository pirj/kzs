# coding: utf-8
class Document < ActiveRecord::Base
  # TODO: remove attributes that never should be assigned using mass-assignment

  attr_accessible :accountable_id,
                  :accountable_type,
                  :approver_id,
                  :body,
                  :confidential,
                  :executor_id,
                  :creator_id, :creator,
                  :conformers, :conformer_ids,
                  :recipient_organization_id,
                  :sender_organization_id,
                  :serial_number,
                  :title

  attr_accessible :accountable,
                  :approver,
                  :executor,
                  :recipient_organization,
                  :sender_organization

  attr_accessible :document_attached_files_attributes, :attached_documents_attributes

  has_many :document_attached_files, dependent: :destroy

  # Приложенные документы
  has_and_belongs_to_many :attached_documents,
                          class_name: "Document",
                          uniq: true,
                          join_table: "attached_documents_relations",
                          foreign_key: "document_id",
                          association_foreign_key: "attached_document_id"

  has_many :document_transitions, dependent: :destroy

  # Согласования
  has_many :conformations, dependent: :destroy

  # Уведомления
  has_many :notifications, dependent: :destroy

  belongs_to :accountable, polymorphic: true, dependent: :destroy

  belongs_to :approver, class_name: 'User'
  belongs_to :executor, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :conformers, class_name: 'User'

  belongs_to :sender_organization, class_name: 'Organization'
  belongs_to :recipient_organization, class_name: 'Organization'

  belongs_to :flow, class_name: 'Documents::Flow'

  accepts_nested_attributes_for :document_attached_files, allow_destroy: true
  accepts_nested_attributes_for :attached_documents,
                                :allow_destroy => true

  alias_attribute :text, :body
  alias_attribute :sn,   :serial_number
  alias_attribute :sender, :sender_organization
  alias_attribute :recipient, :recipient_organization
  alias_attribute :organization_id, :sender_organization_id

  after_save :create_png
  after_create :create_history

  validates_presence_of :title,
                        :sender_organization_id,
                        :approver_id,
                        :executor_id,
                        :body

  validates_presence_of :recipient_organization,
                        unless: :can_have_many_recipients?

  # New Scopes
  scope :lookup, lambda { |query|
    joins(:sender_organization, :recipient_organization)
    .where do
      title.matches("%#{query}%") |
      serial_number.matches("%#{query}%") |
      sender_organization.short_title.matches("%#{query}%") |
      recipient_organization.short_title.matches("%#{query}%")
    end
  }

  # Scope by state
  scope :draft,    -> { where(state: 'draft') }
  scope :prepared,  -> { where(state: 'prepared') }
  scope :approved,  -> { where(state: 'approved') }
  scope :trashed,  -> { where(state: 'trashed') }

  scope :not_draft, -> { where { state.not_eq('draft') } }
  scope :not_trashed, -> { where { state.not_eq('trashed') } }


  # Scope by type
  scope :orders, -> { where(accountable_type: 'Documents::Order') }
  scope :mails,  -> { where(accountable_type: 'Documents::OfficialMail') }
  scope :reports, -> { where(accountable_type: 'Documents::Report') }

  scope :visible_for,  lambda { |org_id|
    where do
      sender_organization_id.eq(org_id) |
      (recipient_organization_id.eq(org_id) &
          state.in(%w(sent accepted rejected)))
    end
  }

  scope :to, ->(org) { where(recipient_organization_id: org) }
  scope :from, ->(org) { where(sender_organization_id: org) }

  # Means that document once passed through *sent* state
  scope :passed_state, lambda { |state|
    joins(:document_transitions)
    .where('document_transitions.to_state' => state)
  }
  scope :inbox, ->(org) { to(org).passed_state('sent') }

  scope :with_notifications_for, -> (user) {includes(:notifications).where("notifications.user_id = #{user.id}")}

  # TODO: default scope for non trashed records
  #   this is also applicable for associated records.

  # default_scope { where { state.not_eq('trashed') } }

  def self.serial_number_for(document)
    "Д-#{document.id}"
  end

  acts_as_readable

  amoeba do
    enable
    exclude_field :flow
    clone [:document_transitions]
  end

  def applicable_states
    accountable.allowed_transitions
  end

  # title and unique-number together
  def unique_title
    "#{Document.serial_number_for(self)} — #{title}"
  end

  # only actual states which shows to user
  def sorted_states
    accountable.state_machine.class.states - %w(trashed unsaved)
  end

  # ordinal number current-state of sorted states
  def current_state_number
    sorted_states.index(accountable.current_state)
  end

  # Stub out all missing methods
  def date
    approved_at
  end

  # if a document was sent #documents_controller.rb
  def sent
    document_transitions.exists?(to_state: 'sent')
  end

  def approved
    document_transitions.exists?(to_state: 'approved')
  end

  def trashed
    document_transitions.exists?(to_state: 'trashed')
  end

  def prepared
    document_transitions.exists?(to_state: 'prepared')
  end

  # TODO-prikha: stub out user_id to replace it properly
  def user_id
    User.first.id
  end

  # Можно ли удалить этот документ?
  # Возвращает true, если документ черновик или документу доступно переведение в статус trashed
  def can_delete?
    draft? || applicable_states.include?('trashed')
  end

  # Черновик?
  def draft?
    state == 'draft'
  end

  # Удалить документ 
  # Если документ - черновик, удаляем навсегда
  # Если документ - не черновик, просто переводим документ в статус "удален", сохраняя юзера, который это сделал
  def destroy_by user
    if draft?
      destroy
    else
      accountable.transition_to!('trashed', {user_id: user.id})
    end
  end

  # Возвращает список пользователей, согласовавших/не согласовавших документ
  # @example
  #   doc.conformed_users
  def conformed_users
    conformations.map(&:user)
  end

  # Возвращает true если все пользователи согласовали документ
  # @example
  #   doc.approvable?
  def approvable?
    (conformers.count == conformations.count) && conformations.pluck(:conformed).all?
  end

  def to_s
    "#{id}"
  end

  #  обнуляем все согласования
  def clear_conformations
    conformations.destroy_all
  end

  # Удаляем нотификацию о текущем документе для всех пользователей (или конкретного пользователя)
  # @param options
  #   - @param for [User] Для какого пользователя удалить
  # @example
  #   doc.clear_notifications # для всех
  #   doc.clear_notifications for: current_user # только для текущего пользователя
  # @see User
  def clear_notifications options = {}
    (options[:for] ? notifications.where("user_id = #{options[:for].id}") : notifications).destroy_all
  end

  def pdf_link
    "/system/documents/document_#{id}.pdf"
  end

  # Посылаем уведомления
  # @param options
  #   - @param only [Array] каким типам интересантов посылать. По-умолчанию: [:approver, :executor, :creator, :conformers]
  #   - @param except [Array] каким типам интересантов не посылать. По-умолчанию: []
  #   - @param exclude [Array] of [User] каким пользователям не посылать. По-умолчанию: []
  # @example
  #   doc.notify_interested only: [:approver], exclude: current_user # Посылаем уведомление только контрольному лицу, если контрольное лицо не текущий юзер
  #   doc.notify_interested except: [:creator], exclude: doc.creator # Посылаем уведомление согласующим, исполнителю и контрольному лицу; если кто-то из них создатель - ему не посылаем
  # @see User
  def notify_interested options = {}
    # Options defaults
    options.reverse_merge! only: [:approver, :executor, :creator, :conformers], except: [], exclude: []
    
    # Оборачиваем параметры в массивы, если переданы просто символами
    options.each {|k, option| options[k] = [option] unless option.class == Array}

    # Убираем те типы, которые не нужны
    options[:only].reject! {|type| options[:except].include? type}

    interested = []

    interested.concat(conformers.to_a) if options[:only].include? :conformers # Добавляем согласующих
    interested << approver if options[:only].include? :approver # Добавляем контрольное лицо
    interested << executor if options[:only].include? :executor # Добавляем исполнителя

    interested.reject! {|user| options[:exclude].include? user} # Не отправляем уведомления тем, кто в списке exclude

    interested.uniq.each { |user| user.notifications.create(document_id: id) }
  end

  private
  # Запрещаем удаление "извне"
  # Вместо destroy используйте destroy_by
  #
  # Это сделано потому, что большинство документов не удаляется на самом деле,
  # а при переводе в статус "удален", нужно также хранить метаданные (например, id пользователя, который удалил документ)
  def destroy
    super
  end

  # Создаем историю изменений
  def create_history
    unless flow
      create_flow
      save!
    end
  end

  def can_have_many_recipients?
    accountable_type == 'Documents::OfficialMail'
  end

  # TODO: remove this nightmare
  def create_png
    path = "public/#{pdf_link}"

    pdf = DocumentPdf.new(self, 'show')
    pdf.render_file path
    pdf = Magick::Image.read(path).first
    thumb = pdf.scale(400, 520)

    Dir.mkdir(path) unless File.exist?(path)
    thumb.write "public/system/documents/document_#{id}.png"
  end
end
