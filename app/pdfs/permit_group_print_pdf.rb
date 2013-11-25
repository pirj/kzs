# coding: utf-8
class PermitGroupPrintPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def remove_html(string)
    sanitize(string, :tags => {}).gsub(/&quot;/i,"").gsub(/&nbsp;/i,"") # empty tags hash tells it to allow no tags
  end
  
  def initialize(permits, view)
    super(margin: 0, :page_size => [243, 158])
    @permits = permits
    @view = view
    russian_font
    
    @permits.each do |permit|
      @user = permit.user
      @organization = Organization.find(@user.organization)
      float {image "#{Rails.root}/app/assets/images/propusk_walker_back.jpg"}
      font "Verdana"
      
      draw_text "#{@organization.title}", :size => 9, :at => [90,147]
      
      draw_text "Пропуск  №", :size => 9, :at => [90,134]
      draw_text "#{permit.number}", :size => 9, :at => [147,134], :style => :bold
      
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
      draw_text "#{permit.expiration_date.strftime('%d.%m.%y')}", :size => 9, :at => [92,5], :style => :bold
      
      unless permit.id == @permits.last.id
        start_new_page
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