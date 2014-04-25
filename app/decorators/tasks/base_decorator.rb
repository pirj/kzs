module Tasks
  class BaseDecorator < Draper::Decorator
    decorate :tasks
    delegate :tasks
    delegate_all
  end
end
