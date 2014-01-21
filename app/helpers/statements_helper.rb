# coding: utf-8

module StatementsHelper
  def statement_status(document)
    if document.accepted?
      '<span class=" label-success btn-available btn" data-toggle="dropdown">Подписан</span>'.html_safe
    elsif document.not_accepted?
        '<span class="btn-available btn label-important"  data-toggle="dropdown">Отклонен</span>'.html_safe
    elsif document.opened?
      '<span class="btn-available btn"  data-toggle="dropdown">Получен</span>'.html_safe
    elsif document.sent?
       if document.organization_id == current_user.organization_id
        '<span class="btn-available btn"  data-toggle="dropdown">Получен</span>'.html_safe
      else
        '<span class="btn-available label-info btn"  data-toggle="dropdown">Отправлен</span>'.html_safe
      end
    elsif document.approved?
      '<span class="btn-available btn"  data-toggle="dropdown">Согласован</span>'.html_safe
     elsif document.prepared?
       '<span class="btn-available btn" data-toggle="dropdown">Подготовлен</span>'.html_safe
    elsif document.draft?
      '<span class="btn-available btn label-inverse"  data-toggle="dropdown">Черновик</span>'.html_safe
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
  
  def statement_status_date(statement)
    if statement.accepted?
      Russian::strftime(statement.accepted_date, "%d %B %Y")
    elsif statement.opened?
      Russian::strftime(statement.opened_date, "%d %B %Y") if statement.opened_date
    elsif statement.sent?
      Russian::strftime(statement.sent_date, "%d %B %Y")
    elsif statement.approved?
      Russian::strftime(statement.approved_date, "%d %B %Y")
    elsif statement.prepared?
      Russian::strftime(statement.prepared_date, "%d %B %Y")
    elsif statement.draft?
      Russian::strftime(statement.date, "%d %B %Y")
    else
      Russian::strftime(statement.date, "%d %B %Y")
    end
  end
  
   def statement_status_progress(statement)
     if statement.accepted?
       100
     elsif statement.opened?
       70
     elsif document.sent
       60
     elsif document.approved?
       40
     elsif document.prepared?
       20
     else
       10
     end
   end

   def statement_status_list(statement)
     created = content_tag(:li, "Создан - " + Russian::strftime(statement.created_at, "%d %B %Y"))
     prepared = content_tag(:li, "Подготовлен - " + Russian::strftime(statement.prepared_date, "%d %B %Y")) if statement.prepared_date
     approved = content_tag(:li,"Подписан - " + Russian::strftime(statement.approved_date, "%d %B %Y")) if statement.approved_date
     sent = content_tag(:li,"Отправлен - " + Russian::strftime(statement.sent_date, "%d %B %Y")) if statement.sent_date
     opened = content_tag(:li,"Открыт - " + Russian::strftime(statement.opened_date, "%d %B %Y")) if statement.opened_date
     accepted = content_tag(:li,"Подписан - " + Russian::strftime(statement.accepted_date, "%d %B %Y")) if statement.accepted_date

     if statement.accepted?
       accepted + opened + sent + approved + prepared
     elsif statement.opened?
       opened + sent + approved + prepared
     elsif statement.sent?
       sent + approved + prepared
     elsif statement.approved?
       approved + prepared
     elsif statement.prepared?
       prepared
     else
       created
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
