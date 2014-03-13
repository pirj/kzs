# coding: utf-8
module Tasks
  class ListShowDecorator < Documents::BaseDecorator
    decorates :task
    delegate_all


  end
end