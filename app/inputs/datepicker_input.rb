class DatepickerInput < SimpleForm::Inputs::StringInput
  enable :value
  def input
    out = '' # the output string we're going to build
    _out = ''
    input_html_classes.push 'form-control js-datepicker'

    # because of original text_field-method override decorates date methods
    input_html_options.merge!( value: @builder.object.send(attribute_name) )

    _out << template.content_tag(:div, class: 'input-group-icon') do
              template.content_tag(:span, nil, class: 'fa fa-calendar')
    end

    _out << (@builder.text_field(attribute_name, input_html_options))

    out << template.content_tag(:div, class: 'input-group') do
              _out.html_safe
    end.html_safe
    # append input as string.
    _out.html_safe
  end
end