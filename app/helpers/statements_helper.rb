# coding: utf-8

module StatementsHelper
  def statement_status(document)
    if document.accepted?
      '<span class=" label-success btn-available btn" data-toggle="dropdown">Подписан</span>'.html_safe
    elsif document.not_accepted?
        '<span class="btn-available btn label-important">Отклонен</span>'.html_safe
    elsif document.opened?
      '<span class="btn-available btn">Получен</span>'.html_safe
    elsif document.sent?
       if document.organization_id == current_user.organization_id
        '<span class="btn-available btn">Получен</span>'.html_safe
      else
        '<span class="btn-available label-info btn">Отправлен</span>'.html_safe
      end
    elsif document.approved?
      '<span class="btn-available btn">Подписан</span>'.html_safe
     elsif document.prepared?
       '<span class="btn-available btn" data-toggle="dropdown">Подписан</span>'.html_safe
    elsif document.draft?
      '<span class="btn-available btn label-inverse">Черновик</span>'.html_safe
    else
      'gbpl'
    end
  end
  
  def statement_indox(current_user)
    count = Statement.unopened.where(:organization_id => current_user.organization_id).count
    count
  end
  
  def for_accept(statement)
    if statement.user_ids.include?(current_user.id) && current_user.has_permission?(2) && 
       statement.statement_approvers.find_by_user_id(current_user.id).accepted != true &&
       statement.task_list.nil? then true 
    end
  end
  
  def statement_approver(approver)
    if User.exists?(approver.user_id)
      User.find(approver.user_id).first_name_with_last_name
    end
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
