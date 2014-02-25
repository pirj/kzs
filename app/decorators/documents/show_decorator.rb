# coding: utf-8
module Documents
  class ShowDecorator < Documents::BaseDecorator
    decorate :document
    delegate_all
    delegate :serial_number

    def title
      h.content_tag :h1, object.title
    end

    def tasks_list
      object.tasks.count
      
    end


  end
end