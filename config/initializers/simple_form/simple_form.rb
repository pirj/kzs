
#inputs = %w[
#  CollectionSelectInput
#  DateTimeInput
#  FileInput
#  GroupedCollectionSelectInput
#  NumericInput
#  PasswordInput
#  RangeInput
#  StringInput
#  TextInput
#]
#
#inputs.each do |input_type|
#  superclass = "SimpleForm::Inputs::#{input_type}".constantize
#
#  new_class = Class.new(superclass) do
#    def input_html_classes
#      super.push('form-control')
#    end
#
#    def label_html_classes
#      super.push('control-label')
#    end
#  end
#
#  Object.const_set(input_type, new_class)
#end
#
SimpleForm.browser_validations = false
#
## Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.label_class = 'control-label'

  config.wrappers :bootstrap3, tag: 'div', class: 'form-group', error_class: 'has-error',
                  defaults: { input_html: { class: 'default_class' } } do |b|

    b.use :html5
    b.use :min_max
    b.use :maxlength
    b.use :placeholder

    b.optional :pattern
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
  end


  config.wrappers :inline, :tag => 'div', :class => 'form-group', :error_class => 'error' do |b|
    b.use :html5
    b.use :placeholder

    b.use :label
    b.wrapper :input_wrapper, tag: 'div' do |bi|
      bi.use :input
    end
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
  end

  config.wrappers :icon_prepend, :tag => 'div', :class => 'form-group', :error_class => 'error' do |b|
    b.use :html5
    b.use :placeholder

    b.use :label
    b.wrapper :input_wrapper, tag: 'div', class: 'input-group' do |bi|
      bi.use :icon, class: 'input-group-icon', tag: 'div'
      bi.use :input
    end

    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
    b.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
  end



  config.wrappers :prepend, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |prepend|
        prepend.use :label , class: 'input-group-addon' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
        prepend.use :input
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :append, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |prepend|
        prepend.use :input
        prepend.use :label , class: 'input-group-addon' ###Please note setting class here fro the label does not currently work (let me know if you know a workaround as this is the final hurdle)
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-block has-error' }
    end
  end

  config.wrappers :checkbox, tag: :div, class: 'checkbox', error_class: "has-error" do |b|

    b.optional :label

    # Form extensions
    b.use :html5

    # Form components
    b.wrapper tag: :label, class: 'control-label' do |ba|
      ba.use :input
      ba.use :label_text, wrap_with: { tag: :span }
    end

    b.use :hint,  wrap_with: { tag: :p, class: "help-block" }
    b.use :error, wrap_with: { tag: :span, class: "help-block text-danger" }
  end

  # Wrappers for forms and inputs using the Twitter Bootstrap toolkit.
  # Check the Bootstrap docs (http://getbootstrap.com/)
  # to learn about the different styles for forms and inputs,
  # buttons and other elements.
  config.default_wrapper = :bootstrap3
end