class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessor :login

  attr_accessible :phone, :position, :division, :info, :dob, :permit, :phone, 
                  :work_status, :organization_id, :email, :password, :password_confirmation, 
                  :avatar, :first_name, :last_name, :middle_name, :username, :right_ids, :remember_me,
                  :is_staff, :is_active, :is_superuser, :date_joined, :permission_ids, :group_ids,
                  :id_type, :id_sn, :id_issue_date, :id_issuer, :alt_name
                  
  has_many :user_permissions
  has_many :permissions, through: :user_permissions, :uniq => true
  has_many :user_groups
  has_many :groups, through: :user_groups, :uniq => true
  has_many :statement_approvers
  has_many :statements, through: :statement_approvers
  has_many :open_notices
  has_one :permit
  
  scope :superuser, -> { where(is_superuser: true) }
  scope :approvers, joins('left outer join user_permissions on users.id=user_permissions.user_id').where("user_permissions.permission_id = '1'")
                              
  WORK_STATUSES = %w[at_work ooo]
  
  validates :username, :first_name, :last_name, :middle_name,
            :id_type, :id_sn, :id_issue_date, :id_issuer, :presence => true
            
  validates :username, uniqueness: true
  
  has_attached_file :avatar, :styles => { :small => "48x48#", :large => "100x100#" } 
  
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
      "#{last_name} #{first_name}"
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

  
end