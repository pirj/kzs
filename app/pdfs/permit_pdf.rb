# coding: utf-8
class PermitPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def remove_html(string)
    sanitize(string, :tags => {}).gsub(/&quot;/i,"").gsub(/&nbsp;/i,"") # empty tags hash tells it to allow no tags
  end
  
  def initialize(permit, view)
    super(margin: 0, :page_size => [595, 420])
    @permit = permit
    @view = view
    russian_font
    

    float {image "#{Rails.root}/app/assets/images/propusk_back.jpg"}

    move_down 140
    
    font "Verdana"
    draw_text "№#{@permit.number}", :size => 25, :at => [484,262]
    
    font "RoadNumbers"
    draw_text "#{@permit.vehicle.register_sn}", :size => 80, :at => [44,100]
    draw_text "#{@permit.vehicle.sn_region}", :size => 55, :at => [288,117]

    # text "#{@permit.vehicle.vehicle_title}", :size => 15
    # text "#{@permit.start_date.strftime('%d.%m.%y')} - #{@permit.expiration_date.strftime('%d.%m.%y')}", :size => 15
  end
  

  
  def russian_font
    font_families.update(
      "Verdana" => {
        :bold => "#{Rails.root}/app/assets/fonts/verdanab.ttf",
        :italic => "#{Rails.root}/app/assets/fonts/verdanai.ttf",
        :normal  => "#{Rails.root}/app/assets/fonts/verdana.ttf" },
      "RoadNumbers" => {
            :normal  => "#{Rails.root}/app/assets/fonts/RoadNumbers2.0.ttf" })
    
  end
end