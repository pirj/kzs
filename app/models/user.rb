class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  attr_accessible :phone, :position, :division, :info, :dob, :phone,
                  :work_status, :organization_id, :email, :password, :password_confirmation,
                  :avatar, :first_name, :last_name, :middle_name, :username, :right_ids, :remember_me,
                  :is_staff, :is_active, :is_superuser, :date_joined, :permission_ids, :group_ids,
                  :id_type, :id_sn, :id_issue_date, :id_issuer, :alt_name, :vehicle_ids, :login, :sys_user

  has_many :user_permissions
  has_many :permissions, through: :user_permissions, :uniq => true
  has_many :user_groups
  has_many :groups, through: :user_groups, :uniq => true
  has_many :statement_approvers
  has_many :statements, through: :statement_approvers
  has_many :open_notices
  belongs_to :permit

  has_many :vehicle_users
  has_many :vehicles, :through => :vehicle_users

  # Согласования
  has_many :conformations, dependent: :destroy

  # Уведомления
  has_many :notifications, dependent: :destroy

  belongs_to :organization

  scope :superuser, -> { where(is_superuser: true) }
  #TODO: такая запись вернет тот же SQL, но будет, возможно, более читаема
  # scope :approvers, includes(:user_permissions).where('user_permissions.permission_id'=>1)
  scope :approvers, joins('left outer join user_permissions on users.id=user_permissions.user_id').where("user_permissions.permission_id = '1'")
  scope :statement_approvers, joins('left outer join user_permissions on users.id=user_permissions.user_id').where("user_permissions.permission_id = '2'")
  scope :for_organization, lambda {|id=nil| where(organization_id: id) }

  WORK_STATUSES = %w[at_work ooo]

  acts_as_reader

  before_save :save_with_empty_password

  validates :first_name, :last_name, :middle_name, :position, :username, presence: true
  #           :id_type, :id_sn, :id_issue_date, :id_issuer, :presence => true
  validates :username, uniqueness: true

  # при решение вопроса курици-и-яйца, было решено, что пользователь является главным
  # и поэтому у него выключаем обязательную организацию
  # validates :organization_id


  has_attached_file :avatar, :plugins => { :small => "48x48#", :large => "100x100#" }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def first_name_with_last_name
      "#{last_name} #{first_name}" if last_name && first_name
  end

  def first_name_with_last_name_with_middle_name
      "#{last_name} #{first_name} #{middle_name}" if last_name && first_name && middle_name
  end

  def last_name_with_initials
       "#{last_name} #{first_name.first}.#{middle_name.first}."
   end

  def self.superusers_from_orgranization(organization_id)
        superuser.where(:organization_id => organization_id)
  end

  def has_permission?(permission_id)
    permissions.exists?(permission_id)
  end

  def save_with_empty_password
  end

  def self.with_permit
    where{permit_id != nil}
  end

  def director?
    organization && organization.director?(self)
  end

  # Согласовать документ
  # @param document [Document] документ
  # @param options
  #   - @param comment [String] комментарий (необязательный параметр)
  # @example
  #   user.conform document, comment: 'Отлично составлено!'
  # @see Document
  def conform(document, options = {})
    options[:comment] ||= ''

    raise RuntimeError, 'User is not in the confomers list for the document' unless document.conformers.include? self
    raise RuntimeError, 'User has already made his decision for this document' if document.conformed_users.include? self

    conformations.create(document_id: document.id, comment: options[:comment], conformed: true)
  end

  # Отказать в согласовании документа
  # @param document [Document] документ
  # @param comment [String] комментарий 
  # @example
  #   user.deny document, 'Я не буду это подписывать!'
  # @see Document
  def deny document, comment
    comment.strip!

    raise ArgumentError, 'Non-empty comment is required' if comment.nil? || comment.empty?
    raise RuntimeError, 'User is not in the confomers list for the document' unless document.conformers.include? self

    conformations.create(document_id: document.id, comment: comment, conformed: false)
  end

  # Голосовал ли пользователь за документ
  # @param document [Document] документ
  # @example
  #  user.made_decision? document
  # @see Document
  # @return true | false
  def made_decision? document
    raise RuntimeError, 'User is not in the confomers list for the document' unless document.conformers.include? self

    conformations.where(document_id: document.id).blank? ? false : true
  end

end