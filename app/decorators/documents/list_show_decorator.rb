# coding: utf-8
module Documents
  class ListShowDecorator < Documents::BaseDecorator
    decorates :organization
    delegate_all


    def number
      h.content_tag( :span, object.sn, class: 'extra' )+
      h.content_tag( :span, object.date, class: 'muted' )
    end

    def sender
      h.link_to object.sender.title, h.organization_path(object.sender), class: 'link' if object.sender
    end

    def recipient
      h.link_to object.recipient.title, h.organization_path(object.recipient), class: 'link' if object.recipient
    end

    def document_type
      h.content_tag :span, object.document_type, class: 'important'
    end

    def status
      h.content_tag :span, 'заглушечка', class: 'label label-danger'
    end

    def attachment
      h.content_tag :span, nil, class: 'fa fa-paperclip icon'
    end

  end
end