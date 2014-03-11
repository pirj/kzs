module SimpleForm
  module Components
    # Needs to be enabled in order to do automatic lookups
    module CheckboxText
      # Name of the component method
      def checkbox_text
        @checkbox_text ||= begin
          options[:checkbox_text].to_s.html_safe if options[:checkbox_text].present?
        end
      end

      # Used when the number is optional
      def has_checkbox_text?
        checkbox_text.present?
      end
    end
  end
end

SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::CheckboxText)