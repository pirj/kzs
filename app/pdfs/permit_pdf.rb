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
      
      draw_text "Пропуск  №", :size => 9, :at => [90,134]
      draw_text "#{@permit.number}", :size => 9, :at => [147,134], :style => :bold
      
      draw_text "Ф.", :size => 9, :at => [90,120]
      draw_text "#{@user.last_name}", :size => 9, :at => [105,120], :style => :bold
      
      draw_text "И.", :size => 9, :at => [90,105]
      draw_text "#{@user.first_name}", :size => 9, :at => [105,105], :style => :bold
      
      draw_text "О.", :size => 9, :at => [90,92]
      draw_text "#{@user.middle_name}", :size => 9, :at => [105,92], :style => :bold
      
      draw_text "Должность:", :size => 9, :at => [90,78]
      draw_text "#{@user.position}", :size => 9, :at => [150,78], :style => :bold
      
      draw_text "Организация:", :size => 9, :at => [90,50]
      draw_text "#{@organization.title}", :size => 9, :at => [160,50], :style => :bold
      
      draw_text "Подпись:", :size => 9, :at => [6,21]
      
      draw_text "Действителен до:", :size => 9, :at => [6,6]
      draw_text "#{@permit.expiration_date.strftime('%d.%m.%y')}", :size => 9, :at => [92,5], :style => :bold

      
    else
      super(margin: 0, :page_size => [595, 420])
      
        if @permit.permit_class == 'vip'
    
          float {image "#{Rails.root}/app/assets/images/propusk_back_VIP.jpg"}
      
          move_down 140

          font "Verdana"
          fill_color(100,83,28,13)
          draw_text "№ #{@permit.number}", :size => 38, :at => [407,128]
        
          fill_color(0,0,0,100)
          font "RoadNumbers"
          draw_text "#{@permit.vehicle.register_sn}", :size => 74, :at => [40,58]
          draw_text "#{@permit.vehicle.sn_region}", :size => 55, :at => [255,72]
          
        else
        
          float {image "#{Rails.root}/app/assets/images/propusk_back.jpg"}
    
          move_down 140

          font "Verdana"
          fill_color(0,0,0,0)
          draw_text "№ #{@permit.number}", :size => 38, :at => [407,244]
      
          fill_color(0,0,0,100)
          font "RoadNumbers"
          draw_text "#{@permit.vehicle.register_sn}", :size => 74, :at => [267,76]
          draw_text "#{@permit.vehicle.sn_region}", :size => 55, :at => [479,88]
          
        end

      
        start_new_page
        
        
        
        if @permit.way_bill
          font "Verdana"
          float {image "#{Rails.root}/app/assets/images/propusk_car_back-2.jpg"}
          draw_text "#{@permit.vehicle.brand}", :size => 20, :at => [200,163]
          
          font "RoadNumbers"
          draw_text "#{@permit.vehicle.register_sn}", :size => 52, :at => [140,93]
          draw_text "#{@permit.vehicle.sn_region}", :size => 36, :at => [304,103]
          draw_text "#{@permit.expiration_date.strftime('%d.%m.%Y')}", :size => 20, :at => [162,57]
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