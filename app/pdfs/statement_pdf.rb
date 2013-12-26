# coding: utf-8
class StatementPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def remove_html(string)
    sanitize(string, :tags => {}).gsub(/&quot;/i,"").gsub(/&nbsp;/i,"") # empty tags hash tells it to allow no tags
  end
  
  def initialize(statement, view)
    super(top_margin: 30)
    @statement = statement
    @organization = Organization.find(@statement.sender_organization_id)
    
    if User.exists?(@organization.director_id) then @director = User.find(@organization.director_id) end
    

    @sender = User.find(@statement.user_id)
    
    @view = view
    russian_font
    logo
    move_down 60
    text "#{@organization.title}", :align => :right, :size => 15
    move_down 5
    stroke_horizontal_rule
    move_down 5
    float {text "<color rgb='989898'>#{@organization.legal_address}</color>", :size => 10, :inline_format => true}
    text "<color rgb='989898'>В #{Organization.find(@statement.organization_id).title}", :align => :right, :size => 10, :inline_format => true
    text "<color rgb='989898'>тел/факс: #{@organization.phone}", :align => :left, :size => 10, :inline_format => true
    text "<color rgb='989898'>#{@organization.mail}", :align => :left, :size => 10, :inline_format => true
    move_down 30
    text "Акт", :align => :center, :size => 20
    move_down 10
    float {text "<color rgb='989898'>Номер документа: #{@statement.id}</color>", :size => 10, :inline_format => true}
    text "<color rgb='989898'>г. Санкт-Петербург</color>", :align => :right, :size => 10, :inline_format => true
    if @statement.date?
      text "<color rgb='989898'>От #{@statement.date.strftime('%d.%m.%Y')}</color>", :size => 10, :inline_format => true
    end
    move_down 30
    text "#{remove_html(@statement.text)}", :size => 10, :inline_format => true, :indent_paragraphs => 60, :align => :justify
    move_down 60
    float {text "Генеральный директор", :size => 10, :inline_format => true}
    move_down 10
    if @director
      text "#{@director.last_name_with_initials}", :align => :right, :size => 10, :inline_format => true
    end
    text "#{@organization.title}", :size => 10
    move_down 20
    text "<color rgb='989898'>Исп: #{@sender.position} отдела: #{@sender.division}</color>", :size => 10, :inline_format => true
    text "<color rgb='989898'>#{@organization.title}</color>", :size => 10, :inline_format => true
    text "#{@sender.last_name_with_initials}", :size => 10, :inline_format => true
  end
  

  
  def russian_font
    font_families.update(
      "Verdana" => {
        :bold => "#{Rails.root}/app/assets/fonts/verdanab.ttf",
        :italic => "#{Rails.root}/app/assets/fonts/verdanai.ttf",
        :normal  => "#{Rails.root}/app/assets/fonts/verdana.ttf" })
    font "Verdana"
  end
  
  def logo
    begin
      float {image "#{@organization.logo.path(:pdf) || ''}", :width => 123}
    rescue
      nil
    end
  end
end