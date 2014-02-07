# coding: utf-8
module Documents
  class ListShowDecorator < Documents::BaseDecorator
    decorates :organization
    delegate_all

    LABEL_COL_WIDTH = 3


    def title_link
      if object.title
        h.link_to object.title, path, class: 'link'
      end
    end

    def number_and_date_with_label
      element_wrapper object.sn || object.date do
        h.content_tag( :div, I18n.t("documents.table.document_labels.number_and_date"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
        h.content_tag( :div, class: "link col-sm-#{12-LABEL_COL_WIDTH}" ) do
          h.content_tag( :b, object.sn )+
          h.content_tag( :span, " / #{object.date}", class: 'muted' )
        end
      end
    end

    def number_and_date
      if object.sn || object.date
        h.content_tag( :b, object.sn )+
        h.content_tag( :span, " / #{object.date}", class: 'muted' )
      end
    end


    # define two same link-with-label with several object atrributes.
    %w(sender recipient).each do |attr|
      define_method "#{attr}_link_with_label" do
        element_wrapper object.send(attr) do
          h.content_tag( :div, I18n.t("documents.table.document_labels.#{attr}"), class: "text-help col-sm-#{LABEL_COL_WIDTH}" )+
          h.link_to( object.send(attr).try(:title), h.organization_path(object.send(attr)), class: "link col-sm-#{12-LABEL_COL_WIDTH}" )
        end
      end
    end


    # define two same links with several object atrributes.
    %w(sender recipient).each do |attr|
      define_method "#{attr}_link" do
        if object.send(attr)
          h.link_to( object.send(attr).try(:title), h.organization_path(object.send(attr)), class: "link")
        end
      end
    end


    def executor_link_with_label
      h.content_tag :h2, 'кто я? я исполнитель?'
    end


    def type
      h.content_tag :span, object.document_type, class: 'important'
    end

    def status
      h.content_tag :span, 'заглушечка', class: 'label label-danger'
    end

    def attachment_icon
      if object.document_attachments.length > 0
        h.content_tag :span, nil, class: 'fa fa-paperclip icon'
      end
    end

    def attachments_count_with_label
      element_wrapper object.document_attachments.length > 0 do
        h.content_tag(:span, I18n.t("documents.table.document_labels.attachments_count"), class: "text-help col-sm-#{LABEL_COL_WIDTH}")+
        h.content_tag( :span, object.document_attachments.try(:count), class: "link col-sm-#{12-LABEL_COL_WIDTH}")
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


    protected
    # wrap elements to 'form-group' to form-horizontal render attributes with labels.
    def element_wrapper(condition, &block)
      if condition
        h.content_tag( :div, class: 'form-group' ) do
          yield
        end
      end
    end

  end
end