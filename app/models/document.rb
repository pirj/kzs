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

  attr_accessible :document_attached_files_attributes

  has_many :document_attached_files

  # Приложенные документы
  has_and_belongs_to_many :attached_documents,
                          class_name: "Document",
                          uniq: true,
                          join_table: "attached_documents_relations",
                          foreign_key: "document_id",
                          association_foreign_key: "attached_document_id"

  has_many :document_transitions

  belongs_to :accountable, polymorphic: true, dependent: :destroy

  belongs_to :approver, class_name: 'User'
  belongs_to :executor, class_name: 'User'
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :conformers, class_name: 'User'

  belongs_to :sender_organization, class_name: 'Organization'
  belongs_to :recipient_organization, class_name: 'Organization'

  # TODO: refactor this
  has_and_belongs_to_many :documents,
                          class_name: "Document",
                          uniq: true,
                          join_table: "document_relations",
                          foreign_key: "document_id",
                          association_foreign_key: "relational_document_id"

  accepts_nested_attributes_for :document_attached_files, allow_destroy: true

  alias_attribute :text, :body
  alias_attribute :sn,   :serial_number
  alias_attribute :sender, :sender_organization
  alias_attribute :recipient, :recipient_organization
  alias_attribute :organization_id, :sender_organization_id

  after_save :create_png
  before_destroy {|document| document.conformers.clear}

  validates_presence_of :title,
                        :sender_organization_id,
                        :approver_id,
                        :executor_id,
                        :body

  validates_presence_of :recipient_organization, unless: :can_have_many_recipients?

  # New Scopes
  scope :lookup, lambda { |query|
    joins(:sender_organization, :recipient_organization)
    .where { title.matches("%#{query}%") | serial_number.matches("%#{query}%") | sender_organization.short_title.matches("%#{query}%") | recipient_organization.short_title.matches("%#{query}%") }
  }


  #Scope by state
  scope :draft,    -> { where(state: 'draft') }
  scope :prepared,  -> { where(state: 'prepared') }
  scope :approved,  -> { where(state: 'approved') }

  scope :not_draft, -> { where{ state.not_eq('draft') } }

  #Scope by type
  scope :orders, -> { where(accountable_type: 'Documents::Order') }
  scope :mails,  -> { where(accountable_type: 'Documents::OfficialMail') }
  scope :reports,-> { where(accountable_type: 'Documents::Report') }

  scope :visible_for,  ->(org_id){
    where do
      sender_organization_id.eq(org_id) |
      (recipient_organization_id.eq(org_id) & state.in(%w(sent accepted rejected)))
    end
  }

  scope :to, ->(org) { where(recipient_organization_id: org) }
  scope :from, ->(org) { where(sender_organization_id: org) }

  # Means that document once passed through *sent* state
  scope :passed_state, ->(state) {
    joins(:document_transitions)
    .where('document_transitions.to_state' => state)
  }
  scope :inbox, ->(o_id) { to(o_id).passed_state('sent') }


  # TODO: default scope for non trashed records
  #   this is also applicable for associated records.

  def self.serial_number_for(document)
    "Д-#{document.id}"
  end

  acts_as_readable

  amoeba do
    #include_field :title
    #include_field :body
    #include_field :confidential
    #include_field :sender_organization_id
    #include_field :recipient_organization_id
    #include_field :approver_id
    #include_field :executor_id
    enable
    clone [:document_transitions]
  end

  def applicable_states
    accountable.allowed_transitions
  end

  # title and unique-number together
  def unique_title
    "#{Document.serial_number_for(self)} — #{self.title}"
  end

  # TODO-justvitalius: please, get it ffrom here
  # actual methods for one instance of Model
  def single_applicable_actions
    %w(edit) if %w(draft prepared).include?(self.accountable.current_state)
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

  def prepared
    document_transitions.exists?(to_state: 'prepared')
  end

  # TODO: @prikha stub out user_id to replace it properly
  def user_id
    User.first.id
  end

  # TODO: add paranoia - this will handle the destruction

  private
  def can_have_many_recipients?
    accountable_type == 'Documents::OfficialMail'
  end

  # TODO: remove this nightmare
  def create_png
    path = "public/system/documents/"

    pdf = DocumentPdf.new(self, 'show')
    pdf.render_file "#{path}document_#{id}.pdf"
    pdf = Magick::Image.read("#{path}document_#{id}.pdf").first
    thumb = pdf.scale(400, 520)

    Dir.mkdir(path) unless File.exists?(path)
    thumb.write "#{path}document_#{id}.png"
  end
end
