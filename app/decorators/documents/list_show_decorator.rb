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
      if object.sender
        h.link_to object.sender.title, h.organization_path(object.sender), class: 'link' if object.sender
      end
    end

    def sender_name
      object.sender.try(:title)
    end

    def recipient
      if object.recipient
        h.link_to object.recipient.title, h.organization_path(object.recipient), class: 'link' if object.recipient
      end
    end

    def recipient_name
      object.recipient.try(:title)
    end

    def recipient_avatar
      if object.recipient
        h.link_to h.organization_path(object.recipient) do
          h.image_tag( "http://cs312521.vk.me/v312521437/5ad5/Az2UeG2pTqg.jpg", class: 'img img-thumbnail table-img-xs')+
          h.content_tag(:span, recipient_name)
          #image_tag object.recipient.avatar.url(:xs), class: 'img img-thumbnail table-img-xs'
        end
      end
    end

    def sender_avatar
      if object.sender
        h.link_to h.organization_path(object.recipient) do
          h.image_tag( "http://cs312521.vk.me/v312521437/5ad5/Az2UeG2pTqg.jpg", class: 'img img-thumbnail table-img-xs')+
          h.content_tag(:span, sender_name)
          #image_tag object.recipient.avatar.url(:xs), class: 'img img-thumbnail table-img-xs'
        end
      end
    end

    def type
      h.content_tag :span, object.document_type, class: 'important'
    end

    def status
      h.content_tag :span, 'заглушечка', class: 'label label-danger'
    end

    def attachment
      h.content_tag :span, nil, class: 'fa fa-paperclip icon'
    end


    # render
    # Sender_link --> Recipient_link
    def sender_to_recipient
      if object.sender && object.recipient
        h.link_to( sender_name, h.organization_path(object.sender), class: 'link link-muted' ) +
        h.content_tag(:span, nil, class: 'fa fa-long-arrow-right text-muted')+
        h.link_to( recipient_name, h.organization_path(object.recipient), class: 'link link-muted' )
      end
    end

  end
end