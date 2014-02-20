class Document < ActiveRecord::Base
  attr_accessible :accountable_id, # Полиморфизм документов
                  :accountable_type, #
                  :approver_id, # пользователь подписант
                  :body, # текст
                  :confidential,#(флаг на прочтение)
                  :executor_id, # пользователь исполнитель
                  :recipient_organization_id, # организация получатель
                  :sender_organization_id, # организация отправитель
                  :serial_number,
                  :title # заголовок(тема)

                  #TODO: кого хранить пользователя, создавшего или пользователя, который послденим изменил документ

  attr_accessible :document_attachments_attributes

  attr_accessible :accountable,
                  :approver,
                  :executor,
                  :recipient_organization,
                  :sender_organization



  has_many :document_attachments
  # StateMachine transitions to keep track of state changes
  # TODO: guards and callbacks on state_machines
  has_many :document_transitions

  belongs_to :accountable, polymorphic: true, dependent: :destroy

  belongs_to :approver, class_name: 'User'
  belongs_to :executor, class_name: 'User'

  belongs_to :sender_organization, class_name: 'Organization'
  belongs_to :recipient_organization, class_name: 'Organization'


  #TODO: add signed_at timestamp and a callback on state machines(m-be a superclass for all state machines)

  #TODO: Better switch to has_many :through.
  has_and_belongs_to_many :documents, class_name: "Document", uniq: true,
                          join_table: "document_relations",
                          foreign_key: "document_id",
                          association_foreign_key: "relational_document_id"

  accepts_nested_attributes_for :document_attachments, allow_destroy: true

  alias_attribute :text, :body
  alias_attribute :sn,   :serial_number
  alias_attribute :sender, :sender_organization
  alias_attribute :recipient, :recipient_organization
  alias_attribute :document_type, :accountable_type #TODO: @prikha remove this misleading alias
  alias_attribute :organization_id, :sender_organization_id


  after_save :create_png

  after_create :save_initial_state

  #New Scopes
  scope :lookup, ->(query){where('documents.title ilike :query or documents.  serial_number ilike :query', query: "%#{query}%")}

  #TODO: validations
  #validates_presence_of :title, :sender_organization_id, :recipient_organization_id, :approver_id, :executor_id, :body

  #
  # With Document.compose_serial_number_for you just make sure
  # that giving serial_numbers is Document`s responsibility
  #
  #
  def self.serial_number_for(document)
    "Д-#{document.id}"
  end

  #Stub all missing scopes
  scope :confidential, where(confidential: true)
  scope :not_confidential, where(confidential: false)

  scope :unread, where(state: 'sent')

  scope :sent_to, ->(organization_id){where(recipient_organization_id: organization_id)}
  scope :approved, joins(:document_transitions).where(document_transitions:{to_state: 'approved'})

  #Actual methods
  # get an array of states that are applicable to this document.
  # it actually belongs to the state machine of a real document
  # among OfficialMail Order Report
  def applicable_states
    accountable.state_machine.applicable_states
  end

  def safe_clone
    whitelist = %w(title body confidential sender_organization_id recipient_organization_id approver_id executor_id)
    document_attributes = self.attributes.keep_if{|k,v| whitelist.include?(k)}
    self.class.new(document_attributes)
  end

  # actual methods for one instance of Model
  def single_applicable_actions
    %w(edit)
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

  # TODO replace it with actual getter method call
  # @date returns timestamp when the document recieved state approved
  def date
    approved_at
    #@date ||= document_transitions.where(to_state: 'approved').order('document_transitions.created_at DESC').pluck(:created_at).first
  end

  #if a document was sent #documents_controller.rb
  def sent
    document_transitions.exists?(to_state: 'sent')
  end

  #maybe we should use a method_missing technique
  def approved
    document_transitions.exists?(to_state: 'approved')
  end

  def prepared
    document_transitions.exists?(to_state: 'prepared')
  end

  #TODO: @prikha stub out user_id to replace it properly
  def user_id
    3
  end

  # TODO: add paranoia - this will handle the destruction

  private
  #TODO: Сохраняем первоначальный стейт таким вот колбэком,
  # потом вынесем это в контроллер чтобы можно было сразу подготовить документ в обход черновика.
  # это кстати поможет нам кэшить переведенное значение. по которому можно фильтровать.
  def save_initial_state
    accountable.transition_to!(:draft)
  end

  #TODO: test manually
  # m-be different generators for different documents
  def create_png
    pdf = DocumentPdf.new(self, 'show')
    pdf.render_file "tmp/document_#{self.id}.pdf"
    pdf = Magick::Image.read("tmp/document_#{self.id}.pdf").first
    thumb = pdf.scale(400, 520)
    thumb.write "public/system/documents/document_#{self.id}.png"
  end
end
