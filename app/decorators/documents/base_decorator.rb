# coding: utf-8
module Documents
  class BaseDecorator < Draper::Decorator
    delegate_all

    def path
      unless object.id.nil?
        h.document_path(object)
      else
        h.new_document_path
      end
    end

    def edit_path
      h.edit_document_path(object)
    end

    def recipient_name
      object.recipient.try(:title)
    end

    def sender_name
      object.sender.try(:title)
    end



    # Humanize object type
    def type_name
      h.content_tag :span, class: 'important' do
        I18n.t("activerecord.attributes.document.accountable_types.#{type}")
      end
    end


    # Transform from Documents::Mail to documents_mail
    def type
      object.accountable_type.to_s.gsub('::', '_').downcase
    end

    # TODO: @justvitalius sdsd

    # TODO: @prikha how to get current_state from Document?
    #       when i decorating DocumentsCollection by this decorator
    #       it return Document class object for each of collection.
    #def state_name
    #  h.content_tag :span, class: 'label' do
    #    I18n.t("activerecord.attributes.document.states.#{object.current_state}")
    #  end
    #end

    # отдает дату в указанном формате
    # obj.date :date_format
    #def date *args
    #  opts = args.extract_options!
    #  DateFormatter.new(object.date, args.first)
    #end


  end
end