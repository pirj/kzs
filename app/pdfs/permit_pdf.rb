# coding: utf-8
class PermitPdf < Prawn::Document
  include ActionView::Helpers::SanitizeHelper

  def remove_html(string)
    sanitize(string, :tags => {}).gsub(/&quot;/i,"").gsub(/&nbsp;/i,"") # empty tags hash tells it to allow no tags
  end
  
  def initialize(permit, view)
    super(top_margin: 30)
    @permit = permit
    @view = view
    russian_font
    text "#{@permit.number}", :size => 15
    text "#{I18n.t(@permit.permit_type)}", :size => 15
    if @permit.permit_type == 'vehicle'
    text "#{@permit.vehicle.vehicle_title}", :size => 15
    else
    @user = User.find(@permit.user_id).first_name_with_last_name
    text "#{@user}", :size => 15
    end
    text "#{I18n.t(@permit.permit_class)}", :size => 15
    text "#{@permit.start_date.strftime('%d.%m.%y')} - #{@permit.expiration_date.strftime('%d.%m.%y')}", :size => 15 
  end
  

  
  def russian_font
    font_families.update(
      "Verdana" => {
        :bold => "#{Rails.root}/app/assets/fonts/verdanab.ttf",
        :italic => "#{Rails.root}/app/assets/fonts/verdanai.ttf",
        :normal  => "#{Rails.root}/app/assets/fonts/verdana.ttf" })
    font "Verdana"
  end
end