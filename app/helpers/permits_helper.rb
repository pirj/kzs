# coding: utf-8
module PermitsHelper
  
  def permit_status(permit)
    if permit.canceled?
      '<span class="btn-available btn label-important">Аннулирован</span>'.html_safe
    elsif permit.issued?
      '<span class="btn-available btn label-success">Выдан</span>'.html_safe
    elsif permit.released?
      '<span class="btn-available btn label-success">Выпущен</span>'.html_safe
    elsif permit.canceled?
      '<span class="btn-available btn label-important">Аннулирован</span>'.html_safe
    elsif permit.agreed?
       '<span class="btn-available btn label-info">Согласован</span>'.html_safe
    else
       '<span class="btn-available btn label-ready">Заявка</span>'.html_safe
    end
  end
end
