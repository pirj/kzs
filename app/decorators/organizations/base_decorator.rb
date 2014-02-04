# coding: utf-8
module Organizations
  class BaseDecorator < Draper::Decorator
    delegate_all

    # render title by format:
    # '<span>NAME,</span><span>OOO</span>
    def full_title
      ads = if object.type_of_ownership
              h.content_tag(:span, ', ')+
              h.content_tag(:span, object.type_of_ownership, class: 'text-muted')
            end
      h.content_tag(:span, object.short_title)+
      ads
    end

    def director_name
      if object.director
        "#{object.director.last_name} #{object.director.first_name.first}.#{object.director.middle_name.first}."
      end
    end

    def director_full_name
      if object.director
        object.first_name_with_last_name
      end
    end

    def director_avatar
      h.image_tag( director.avatar, class: 'img img-thumbnail table-img-xs' ) if object.director && object.director.avatar?
    end

    def phone
      object.phone
    end

    def users_count
      object.users.count
    end

    def path
      unless object.id.nil?
        h.organization_path(object)
      else
        h.new_organization_path
      end
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
end