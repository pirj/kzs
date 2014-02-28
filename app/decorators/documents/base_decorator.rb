# coding: utf-8
module Documents
  class BaseDecorator < Draper::Decorator
    delegate_all

    LABEL_COL_WIDTH = 3

    def path
      unless object.id.nil?
        h.documents_document_path(object)
      end
    end

    def edit_path
      h.edit_documents_documents_path(object)
    end

    def recipient_name
      object.recipient.try(:title)
    end

    def sender_name
      object.sender.try(:title)
    end





    # Humanize object type
    def type_name
      h.content_tag :span, class: 'text-important' do
        I18n.t("activerecord.attributes.document.accountable_types.#{type}")
      end
    end


    # Transform from Documents::Mail to documents_mail
    def type
      object.accountable_type.to_s.gsub('::', '_').downcase
    end

    def actions
      collection = object.accountable.applicable_states || []
      single = object.accountable.single_applicable_actions || []
      (collection + single).to_s
    end

    def state popover_position = :left
      model_scope = object.accountable_type.downcase.gsub('documents::','')
      a = (object.sender_organization.id == h.current_user.organization_id) ? '_sender' : '_recipient'

      state = object.accountable.current_state.to_s
      state += (state.to_sym == :sent) ? a : ''

      css_class = case object.accountable.current_state.to_sym
                    when :draft then 'default'
                    when :prepared then 'primary'
                    when :approved then 'success'
                    when :sent then 'warning'
                    when :read then 'warning'
                    when :trashed then 'danger'
                    else 'default'
                  end
      h.link_to '#', class: "label label-#{css_class} js-document-state-link", data: { content: h.html_escape( h.render_document_status_bar(object) ), placement: popover_position.to_s } do
        I18n.t("activerecord.attributes.document.states.#{model_scope}.#{state}")
      end
    end

    # define two same link-with-label for Organization model.
    %w(sender recipient).each do |attr|
      define_method "#{attr}_link_with_label" do
        element_wrapper object.send(attr) do
          h.content_tag( :div, I18n.t("documents.table.document_labels.#{attr}"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
              h.link_to( object.send(attr).try(:title), h.organization_path(object.send(attr)), class: "link col-sm-#{12-LABEL_COL_WIDTH}" )
        end
      end
    end

    # define two same link-with-label for User model.
    %w(executor approver).each do |attr|
      define_method "#{attr}_link_with_label" do
        element_wrapper object.send(attr) do
          h.content_tag( :div, I18n.t("documents.table.document_labels.#{attr}"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
              h.link_to( object.send(attr).try(:first_name_with_last_name), h.organization_path(object.send(attr)), class: "link col-sm-#{12-LABEL_COL_WIDTH}" )
        end
      end
    end


    # render
    # Sender_link --> Recipient_link
    def sender_to_recipient_links
      if object.sender && object.recipient
        h.link_to( sender_name, h.organization_path(object.sender), class: 'link link-muted' ) +
            h.content_tag(:span, nil, class: 'fa fa-long-arrow-right text-muted')+
            h.link_to( recipient_name, h.organization_path(object.recipient), class: 'link link-muted' )
      end
    end

    def number_and_date_with_label
      element_wrapper object.serial_number || object.approved_at do
        h.content_tag( :div, I18n.t("documents.table.document_labels.number_and_date"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
            h.content_tag( :div, class: " col-sm-#{12-LABEL_COL_WIDTH}" ) do
              h.content_tag( :b, object.serial_number, class: 'link' )+
                  h.content_tag( :span, " / #{approved_at}", class: 'muted' )
            end
      end
    end

    def creator_with_label
      element_wrapper object.creator do
        h.content_tag( :div, I18n.t("documents.table.document_labels.creator"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
          h.link_to( object.creator.try(:first_name_with_last_name), h.organization_path( object.creator), class: "link col-sm-#{12-LABEL_COL_WIDTH}" )
      end
    end

    def conformer_link_with_label
      if object.conformers.empty?

      else




        a = h.content_tag( :div, I18n.t("documents.table.document_labels.conformer"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
            h.content_tag( :div, (wasd), class: "link col-sm-#{12-LABEL_COL_WIDTH}" )
        h.content_tag(:div, a, class: "row form-group")


      end

      #  element_wrapper object.conformers do
      #  h.content_tag( :div, 'wasd', class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
      #      h.content_tag( :b, object.conformers.length, class: 'link' )
      #end
    end

    def wasd
      object.conformers.map do |user|
        user.first_name_with_last_name
      end.join(', ')
    end

    def deadline_date

      element_wrapper object.deadline do
        h.content_tag( :div, I18n.t("documents.table.document_labels.deadline"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
            h.content_tag( :div, class: " col-sm-#{12-LABEL_COL_WIDTH}" ) do
              h.content_tag( :span, "#{deadline}", class: 'muted' )
            end
      end
    end


    def body
      h.content_tag( :span, "#{object.body}", class: 'doc-text' )

    end

    def related_order_link_with_label
      element_wrapper object.class == Documents::Report do


          h.content_tag( :div, I18n.t("documents.table.document_labels.related_order"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
              h.content_tag( :div, class: " col-sm-#{12-LABEL_COL_WIDTH}" ) do
                h.content_tag( :span, Documents::Order.find(object.order_id).title, class: 'muted' )
              end
      end
    end

    protected
    # wrap elements to 'form-group' to form-horizontal render attributes with labels.
    def element_wrapper(condition, &block)
      if condition
        h.content_tag( :div, class: 'form-group row' ) do
          yield
        end
      end
    end

    def approved_at
      DateFormatter.new(object.approved_at, :long)
    end

    def deadline
      DateFormatter.new(object.deadline)
    end


  end
end