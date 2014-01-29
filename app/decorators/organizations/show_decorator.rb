# coding: utf-8
module Organizations
  class ShowDecorator < Draper::Decorator
    delegate_all

    ATTACH_ATTR = [:certificate_of_tax_registration, :articles_of_organization, :creation_resolution, :egrul_excerpt]
    USER_ATTR =   [:director, :account]
    DATE_ATTR =   [:date_of_registration, :creation_resolution_date, :egrul_registration_date]

    # render Model methods in html
    # need to render only attr with saved information
    def method_missing(method, *args)
      unless object.try(method, *args).to_s.empty?
        case method.to_sym
          when *ATTACH_ATTR
            file_info(method, *args)
          when *USER_ATTR
            user_info(method, *args)
          when *DATE_ATTR
            date_info(method, *args)
          else
            text_info(method, *args)
          end
      end
    end


    protected
    # render link to attached file
    def file_info(method, *args)
      if object.try("#{method}?")
        label(method) +
        h.link_to('скачать', object.public_send(method, *args).public_send(:url, :original), class: 'link' )
      end
    end

    # render saved text
    def text_info(method, *args)
      label(method) +
      h.content_tag( :div, object.public_send(method, *args), class: 'text' )
    end

    # render connected user
    def user_info(method, *args)
      user = object.public_send(method)
      label(method) +
      h.link_to( user.first_name_with_last_name, h.user_path(user), class: 'link-dashed' )
    end

    # render saved date
    def date_info(method, *args)
      date = DateFormatter.new(object.public_send(method, *args))
      label(method) +
      h.content_tag( :div, date, class: 'text' )
    end

    # render label for saved information
    def label(method)
      h.content_tag( :div, object.class.human_attribute_name(method), class: 'text-help' )
    end

  end
end