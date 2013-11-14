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
    if statement.organization_id == current_user.organization_id && statement.sent == true then true end
  end
  
end
