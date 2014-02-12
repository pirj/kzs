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
                  #TODO: после стейт машин необходимо добавить signed_at, - дата когда документ был подписан(возможно кэш)

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
  alias_attribute :date, :created_at
  alias_attribute :organization_id, :sender_organization_id




  after_save :create_png



  #TODO: validations
  #validates_presence_of :title, :sender_organization_id, :recipient_organization_id, :approver_id, :executor_id, :body

  def self.text_search(query)
    query ? where('title ilike :query or body ilike :query', query: "%#{query}%") : scoped
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
  def single_applicable_states
    %w(edit)
  end

  # Stub out all missing methods

  # @date returns timestamp when the document recieved state approved
  def date
    @date ||= document_transitions.where(to_state: 'approved').order('document_transitions.created_at DESC').pluck(:created_at).first
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

  # TODO: manually cache initial state
  # here we can go with default value on column
  # or disable initial state on state machine and call transition to it from the model


  private

  #TODO: test manually
  # m-be different generators for different documents
  def create_png
    pdf = DocumentPdf.new(self, 'show')
    pdf.render_file "tmp/document_#{self.id}.pdf"
    pdf = Magick::Image.read("tmp/document_#{self.id}.pdf").first
    thumb = pdf.scale(400, 520)
    thumb.write "app/assets/images/document_#{self.id}.png"
  end


end
