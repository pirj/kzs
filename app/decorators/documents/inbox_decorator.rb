module Documents
  class InboxDecorator < Documents::BaseDecorator
    decorate :inbox
    delegate_all

    def badge(type = nil)
      counter = count_by_type(type)
      h.content_tag(:span, counter, class: 'badge') unless counter < 1
    end

    def row_class(document)
      readable = incoming.exists?(id: document.id)
      unread = document.unread?(h.current_user)
      (readable && unread) ? 'tr-unread' : 'tr-read'
    end
  end
end