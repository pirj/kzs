module OrganizationsHelper
  
  def possession(organization)
    if organization.parent_id? 
  	  Organization.find(organization.parent_id).title
  	else 
  		'-'
  	end
	end
  
  def organization_short_title(id)
	  if Organization.exists?(id)
	    Organization.find(id).short_title
    end
  end
  
end
