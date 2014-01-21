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

  def permit_progress(permit)

    #all_days = (permit.expiration_date - permit.start_date).to_i
    #days_done = (DateTime.now.to_date - permit.start_date).to_i
    #"#{all_days} #{days_done}"
  end

  def permit_remaining(permit)
  #  Time.now
  #  t = Time.now
  #  a = DateTime.parse(permit.expiration_date)
  #  b = DateTime.parse(permit.start_date)
  #  c = (t - 10)
    distance_of_time_in_words(permit.start_date, permit.expiration_date)
  end
end
