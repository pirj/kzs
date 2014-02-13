# coding: utf-8
module Documents
  class ShowDecorator < Documents::BaseDecorator
    decorate :document
    delegate_all

    def title
      h.content_tag :h1, object.title
    end
  end
end