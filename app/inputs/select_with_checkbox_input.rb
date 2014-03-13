# coding: utf-8
class SelectWithCheckboxInput < SimpleForm::Inputs::CollectionInput

  def input
    out = ''
    out <<  template.content_tag(:div, class: 'row') do
              checkbox_with_title + select
            end
    #out = updated_html_options.inspect
    out.html_safe
  end

  protected

  def updated_html_options
    required_options = { data: { target: uniq_name }, disabled: :disabled }
    input_html_classes.push('js-chosen') # добавляем, чтобы включить chosen
    input_html_options[:data].merge!(required_options[:data]) if input_html_options[:data].present? # иначе никак не слить data атрибуты,чтобы не потерять их из разных мест
    required_options.merge(input_html_options) # окончательно сливаем элементы первого уровня
  end

  def select
    label_method, value_method = detect_collection_methods



    template.content_tag(:div, class: "col-sm-#{12-check_box_col}") do
      @builder.collection_select(
          attribute_name, collection, value_method, label_method,
          input_options, updated_html_options
      )
    end
  end

  def checkbox
    template.check_box_tag("is_#{attribute_name}".to_sym, nil, false, class: 'js-active-input', data: { target: uniq_name  })
  end

  def checkbox_title(&block)
    template.label_tag("is_#{attribute_name}".to_sym)  do
      yield +
      template.content_tag(:span, checkbox_text)
    end
  end

  def checkbox_with_title
    template.content_tag(:div, class: "col-sm-#{check_box_col}") do
      template.content_tag(:div, class: 'checkbox') do
        if has_checkbox_text?
          checkbox_title do
            checkbox
          end
        else
          checkbox
        end
      end
    end
  end


  def check_box_col
    has_checkbox_text? ? 4 : 1
  end

  def uniq_name
    @select_with_checkbox_input_uniq_time ||= "#{attribute_name}-#{(DateTime.now.to_f*10**5).to_i.to_s}"
  end

end