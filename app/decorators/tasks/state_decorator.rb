module Tasks
  class StateDecorator < Draper::Decorator
    delegate_all
    decorates :task

    def state
      h.content_tag :span, I18n.t("activerecord.tasks/task.state.#{object.current_state.to_s}"), class: css_class_for_current_state
    end

    private

    # def translates_to_state(scope, state)
    #   prefix = accountable.class.to_s.underscore
    #   I18n.t("activerecord.task.#{prefix}.#{scope}.#{state}")
    # end
    def css_class_for_current_state
      css_class_for object.current_state.to_s
    end

    def css_class_for state
      css_class = 'primary'
      css_class = case current_state.to_sym
                    when :formulated then 'label-orange label'
                    when :activated then 'label-blue label'
                    when :cancelled then 'label-asphalt label'
                    when :executed then 'label-green label'
                    when :paused then 'label-default label'
                    else 'label-default label'
                  end
      css_class
    end

  end
end