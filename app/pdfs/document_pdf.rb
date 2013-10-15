# coding: utf-8
class DocumentPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def remove_html(string)
    sanitize(string, :tags => {}).gsub(/&quot;/i,"").gsub(/&nbsp;/i,"") # empty tags hash tells it to allow no tags
  end
  
  def initialize(document, view)
    super(top_margin: 30)
    @document = document
    @organization = Organization.find(@document.sender_organization_id)
    @director = User.find(@organization.director_id)
    @sender = User.find(@document.user_id)
    
    @view = view
    russian_font
    logo
    move_down 60
    text "#{@organization.title}", :align => :right, :size => 15
    move_down 5
    stroke_horizontal_rule
    move_down 5
    float {text "<color rgb='989898'>#{@organization.address}</color>", :size => 10, :inline_format => true}
    text "<color rgb='989898'>В #{Organization.find(@document.organization_id).title}", :align => :right, :size => 10, :inline_format => true
    text "<color rgb='989898'>тел/факс: #{@organization.phone}", :align => :left, :size => 10, :inline_format => true
    text "<color rgb='989898'>#{@organization.mail}", :align => :left, :size => 10, :inline_format => true
    move_down 30
    text "Письмо", :align => :center, :size => 20
    move_down 10
    float {text "<color rgb='989898'>Номер документа: #{@document.sn}</color>", :size => 10, :inline_format => true}
    text "<color rgb='989898'>г. Санкт-Петербург</color>", :align => :right, :size => 10, :inline_format => true
    if @document.date?
      text "<color rgb='989898'>От #{@document.date.strftime('%d.%m.%Y')}</color>", :size => 10, :inline_format => true
    end
    move_down 30
    text "#{remove_html(@document.text)}", :size => 10, :inline_format => true, :indent_paragraphs => 60, :align => :justify
    move_down 60
    float {text "Генеральный директор", :size => 10, :inline_format => true}
    text "#{@director.last_name_with_initials}", :align => :right, :size => 10, :inline_format => true
    text "#{@organization.title}", :size => 10
    move_down 20
    if @document.executor_id
      @executor = User.find(@document.executor_id)
      text "<color rgb='989898'>Исп: #{@executor.position} отдела: #{@executor.division}</color>", :size => 10, :inline_format => true
      text "<color rgb='989898'>#{@organization.title}</color>", :size => 10, :inline_format => true
      text "#{@executor.last_name_with_initials}", :size => 10, :inline_format => true
    end
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
    float {image "#{@organization.logo.path(:pdf)}", :width => 123}
  end
end