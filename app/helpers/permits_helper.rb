# coding: utf-8
module PermitsHelper
  
  def permit_status(permit)
    if permit.canceled?
      '<span class="label label-important">Аннулирован</span>'.html_safe
    elsif permit.issued?
      '<span class="label label-success">Выдан</span>'.html_safe
    elsif permit.released?
      '<span class="label label-success">Выпущен</span>'.html_safe
    elsif permit.canceled?
      '<span class="label label-important">Аннулирован</span>'.html_safe    
    elsif permit.agreed?
       '<span class="label label-info">Согласован</span>'.html_safe
    else
       '<span class="label label-ready">Заявка</span>'.html_safe
    end
  end
end
