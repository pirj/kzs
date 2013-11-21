# coding: utf-8
class PermitPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def remove_html(string)
    sanitize(string, :tags => {}).gsub(/&quot;/i,"").gsub(/&nbsp;/i,"") # empty tags hash tells it to allow no tags
  end
  
  def initialize(permit, view)
    super(margin: 0, :page_size => [243, 158])
    
    @permit = permit
    @view = view
    russian_font
    
    if @permit.permit_type == 'user'
      
      @user = @permit.user
      @organization = Organization.find(@user.organization)
      float {image "#{Rails.root}/app/assets/images/propusk_walker_back.jpg"}
      font "Verdana"
      
      draw_text "#{@organization.title}", :size => 9, :at => [90,147]
      
      draw_text "Пропуск №", :size => 9, :at => [90,134]
      draw_text "#{@permit.number}", :size => 9, :at => [147,134]
      
      draw_text "Ф.", :size => 9, :at => [90,120]
      draw_text "#{@user.last_name}", :size => 9, :at => [105,120]
      
      draw_text "И.", :size => 9, :at => [90,105]
      draw_text "#{@user.first_name}", :size => 9, :at => [105,105]
      
      draw_text "О.", :size => 9, :at => [90,92]
      draw_text "#{@user.middle_name}", :size => 9, :at => [105,92]
      
      draw_text "Должность:", :size => 9, :at => [90,78]
      draw_text "#{@user.position}", :size => 9, :at => [150,78]
      
      draw_text "Организация:", :size => 9, :at => [90,50]
      draw_text "#{@organization.title}", :size => 9, :at => [160,50]
      
      draw_text "Подпись:", :size => 9, :at => [6,21]
      
      draw_text "Действителен до:", :size => 9, :at => [6,6]
      draw_text "#{@permit.expiration_date.strftime('%d.%m.%y')}", :size => 9, :at => [92,5]

      
    else
      super(margin: 0, :page_size => [595, 420])

      
    
      if @permit.start_date == @permit.expiration_date
        float {image "#{Rails.root}/app/assets/images/propusk_temporary.jpg"}
      
        font "Verdana"
        draw_text "#{@permit.expiration_date.strftime('%d.%m.%y')}", :size => 30, :at => [425,285]
        draw_text "№#{@permit.number}", :size => 25, :at => [500,250]
      
        font "RoadNumbers"
        draw_text "#{@permit.vehicle.register_sn}", :size => 80, :at => [228,115]
        draw_text "#{@permit.vehicle.sn_region}", :size => 55, :at => [474,130]
      
      
      else
        float {image "#{Rails.root}/app/assets/images/propusk_back.jpg"}
      
        move_down 140

        font "Verdana"
        draw_text "№#{@permit.number}", :size => 25, :at => [484,262]

        font "RoadNumbers"
        draw_text "#{@permit.vehicle.register_sn}", :size => 80, :at => [44,100]
        draw_text "#{@permit.vehicle.sn_region}", :size => 55, :at => [288,117]
  
      end
        start_new_page
        if @permit.way_bill
          
        else
          @drivers = @permit.vehicle.users
          @driver = @drivers.first
          font "Verdana"
          float {image "#{Rails.root}/app/assets/images/propusk_front.jpg"}
          draw_text "#{@driver.last_name}", :size => 20, :at => [160,360]
          draw_text "#{@driver.first_name}   #{@driver.middle_name}", :size => 20, :at => [160,300]
          draw_text "#{@driver.position}", :size => 20, :at => [160,237]
          if @driver.organization_id?
          draw_text "#{Organization.find(@driver.organization_id).title}", :size => 20, :at => [160,180]
          end
          draw_text "#{@permit.vehicle.register_sn} #{@permit.vehicle.sn_region}", :size => 20, :at => [240,120]
          draw_text "#{@permit.expiration_date.strftime('%d.%m.%y')}", :size => 20, :at => [165,65]
        end
    
      end
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