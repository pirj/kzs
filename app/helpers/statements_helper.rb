# coding: utf-8

module StatementsHelper
  def statement_status(document)
    if document.accepted?
      '<span class="label label-success">Подписан</span>'.html_safe
    elsif document.not_accepted?
        '<span class="label label-important">Отклонен</span>'.html_safe     
    elsif document.opened?
      '<span class="label">Прочитан</span>'.html_safe
    elsif document.sent?
       '<span class="label label-info">Не прочитан</span>'.html_safe   
     elsif document.prepared?
       '<span class="label">Подготовлен</span>'.html_safe
    elsif document.draft?
      '<span class="label label-inverse">Черновик</span>'.html_safe
    else
      nil
    end
  end
  
  def for_accept(statement)
    
    if statement.user_ids.include?(current_user.id) && current_user.has_permission?(2) && 
       statement.statement_approvers.find_by_user_id(current_user.id).accepted != true then true end
    
    
      
  end
  
  def statement_approver(approver)
    User.find(approver.user_id).first_name_with_last_name
  end
  
  def statement_approver_status(approver)
    if approver.accepted == true
      status = "Принят"
    elsif approver.accepted == false
      status = "Не принят"
    else
      status = "Ожидание"
    end
  end
  
end
