# coding: utf-8
module PermitsHelper
  
  def permit_status(permit)
    if permit.canceled?
      '<span class="label label-danger">Аннулирован</span>'.html_safe
    elsif permit.issued?
      '<span class="label label-success">Выдан</span>'.html_safe
    elsif permit.released?
      '<span class="label label-success">Выпущен</span>'.html_safe
    elsif permit.canceled?
      '<span class="label label-danger">Аннулирован</span>'.html_safe
    elsif permit.agreed?
       '<span class="label label-primary">Согласован</span>'.html_safe
    else
       '<span class="label label-default">Заявка</span>'.html_safe
    end
  end

  def permit_progress(permit)

    #all_days = (permit.expiration_date - permit.start_date).to_i
    #days_done = (DateTime.now.to_date - permit.start_date).to_i
    #"#{all_days} #{days_done}"
    if permit.expiration_date
      distance_of_time_in_words(Time.new.inspect, permit.expiration_date)
    end
  end

  def permit_remaining(permit)
  #  Time.now
  #  t = Time.now
  #  a = DateTime.parse(permit.expiration_date)
  #  b = DateTime.parse(permit.start_date)
  #  c = (t - 10)
    if permit.start_date&&permit.expiration_date
      distance_of_time_in_words(permit.start_date, permit.expiration_date)
    end

  end


  def permit_auto_number(permit)

 #  content_tag(:span, "Hello world!", class: 'wasd')


   return permit.vehicle.register_sn[0].to_s +  permit.vehicle.register_sn[1..3].to_s + permit.vehicle.register_sn[4..5].to_s + permit.vehicle.sn_region.to_s
  end
end
