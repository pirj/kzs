# coding: utf-8
class SelectWithCheckboxInput < SimpleForm::Inputs::CollectionInput

  def input
    out = ''
    out <<  template.content_tag(:div, class: 'row') do
              checkbox_with_title + select
            end

    out.html_safe
  end

  protected

  def select
    label_method, value_method = detect_collection_methods

    template.content_tag(:div, class: "col-sm-#{12-check_box_col}") do
      @builder.collection_select(
          attribute_name, collection, value_method, label_method,
          input_options, input_html_options
      )
    end
  end

  def checkbox
    template.check_box_tag("is_#{attribute_name}".to_sym)
  end

  def checkbox_title &block
    template.label_tag("is_#{attribute_name}".to_sym)  do
      yield +
      template.content_tag(:span, checkbox_text)
    end
  end

  def checkbox_with_title
    if has_checkbox_text?
      template.content_tag(:div, class: "col-sm-#{check_box_col}") do
        template.content_tag(:div, class: 'checkbox') do
          checkbox_title do
            checkbox
          end
        end
      end
    else
      template.content_tag(:div, class: "col-sm-#{check_box_col}") do
        template.content_tag(:div, class: 'checkbox') do
          checkbox
        end
      end
    end
  end


  def check_box_col
    has_checkbox_text? ? 4 : 1
  end

end