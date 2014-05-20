module Tasks
  class StateDecorator < Draper::Decorator
    delegate_all
    decorates :task

    # def translates_to_state(scope, state)
    #   prefix = accountable.class.to_s.underscore
    #   I18n.t("activerecord.task.#{prefix}.#{scope}.#{state}")
    # end

  end
end