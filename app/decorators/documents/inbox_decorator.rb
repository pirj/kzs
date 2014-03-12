module Documents
  class InboxDecorator < Documents::BaseDecorator
    decorate :inbox
    delegate_all

    def badge(type=nil)
      h.content_tag(:span, count_by_type(type) ,class: 'badge')
    end

    def row_class(document)
      readable = incoming.exists?(id: document.id)
      unread = document.unread?(h.current_user)
      (readable && unread) ? 'tr-unread' : 'tr-read'
    end
  end
end