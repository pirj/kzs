class Document < ActiveRecord::Base
  attr_accessible :accountable_id, # Полиморфизм документов
                  :accountable_type, #
                  :approver_id, # пользователь подписант
                  :body, # текст
                  :confidential,#(флаг на прочтение)
                  :executor_id, # пользователь исполнитель
                  :recipient_organization_id, # организация получатель
                  :sender_organization_id, # организация отправитель
                  :state, #кэш текущего для общей таблицы
                  :serial_number,
                  :title # заголовок(тема)

                  #TODO: кого хранить пользователя, создавшего или пользователя, который послденим изменил документ
                  #TODO: после стейт машин необходимо добавить signed_at, - дата когда документ был подписан(возможно кэш)

  attr_accessible :document_attachments_attributes


  has_many :document_attachments
  accepts_nested_attributes_for :document_attachments, allow_destroy: true

  belongs_to :accountabe, polymorphic: true

  belongs_to :approver, class_name: 'User'
  belongs_to :executor, class_name: 'User'

  belongs_to :sender_organization, class_name: 'Organization'
  belongs_to :recipient_organization, class_name: 'Organization'

  # StateMachine transitions to keep track of state changes
  has_many :document_transitions

  #TODO: Better switch to has_many :through.
  has_and_belongs_to_many :documents, class_name: "Document", uniq: true,
                          join_table: "document_relations",
                          foreign_key: "document_id",
                          association_foreign_key: "relational_document_id"


  alias_attribute :text, :body
  alias_attribute :sn, :serial_number


  after_save :create_png

  #TODO: test manually
  def self.text_search(query)
    query ? where("title ilike ? or body ilike ?", query) : scoped
  end

  #TODO: validations
  #validates_presence_of :title, :organization_id, :approver_id, :executor_id, :text

  # TODO: add paranoia - this will handle the destruction

  private

  #TODO: test manually
  def create_png
    pdf = DocumentPdf.new(self, 'show')
    pdf.render_file "tmp/document_#{self.id}.pdf"
    pdf = Magick::Image.read("tmp/document_#{self.id}.pdf").first
    thumb = pdf.scale(400, 520)
    thumb.write "app/assets/images/document_#{self.id}.png"
  end


end
