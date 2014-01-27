# coding: utf-8
class OrganizationDecorator < Draper::Decorator
  delegate_all



  def name
    h.content_tag( :span, "#{object.short_title}, ", class: 'extra inline' )+
    h.content_tag( :span, object.type_of_ownership, class: 'muted inline' )
  end

  def director_name
    "#{object.director.last_name} #{object.director.first_name.first}.#{object.director.middle_name.first}."
  end

  def director_avatar
    h.image_tag( director.avatar, class: 'img img-thumbnail table-img-xs' ) if director.avatar?
  end

  def phone
    object.phone
  end

  def users_count
    object.users.count
  end

  def path
    h.organization_path(object)
  end

  def edit_path
    h.edit_organization_path(object)
  end

  # отдает дату в указанном формате
  # obj.date :date_format
  def date *args
    opts = args.extract_options!
    DateFormatter.new(object.date, args.first)
  end
end