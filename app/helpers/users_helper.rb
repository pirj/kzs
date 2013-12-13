module UsersHelper
  
  def organzation_title(user)
    if user.organization_id?
  	  Organization.find(user.organization_id).title
  	else 
  		'-'
  	end
	end
	
  def organzation_title_by_user_id(user_id)
    user = User.find(user_id)
      if user.organization_id?
        Organization.find(user.organization_id).title
      else 
        '-'
      end
  end
  
	def organzation_title_by_user_id(user_id)
    if User.exists?(user_id)
      user = User.find(user_id)
        if user.organization_id?
          Organization.find(user.organization_id).title
        else 
          '-'
        end
     end
  end
	
	def user(user_id)
	  if User.exists?(user_id)
      user = User.find(user_id)
	  end
  end
  
  def user_with_full_name(user_id)
	  if User.exists?(user_id)
      user = User.find(user_id)
      user.first_name_with_last_name
	  end
  end
  
end
