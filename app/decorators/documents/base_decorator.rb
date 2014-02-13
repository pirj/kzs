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

    def actions
      (object.applicable_states + object.single_applicable_states).to_s
    end

    def state
      css_class = case object.accountable.current_state.to_sym
                    when :draft then 'default'
                    when :prepared then 'primary'
                    when :approved then 'success'
                    when :sent then 'warning'
                    when :read then 'warning'
                    when :trashed then 'danger'
                    else 'default'
                  end
      h.content_tag :span, class: "label label-#{css_class}" do
        I18n.t("activerecord.attributes.document.states.#{object.accountable.current_state}")
      end
    end

    # отдает дату в указанном формате
    # obj.date :date_format
    #def date *args
    #  opts = args.extract_options!
    #  DateFormatter.new(object.date, args.first)
    #end


  end
end