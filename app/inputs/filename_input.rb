class FilenameInput < SimpleForm::Inputs::FileInput
  def input
    out = '' # the output string we're going to build
    input_html_classes.push 'form-control'
    # check if there's an uploaded file (eg: edit mode or form not saved)
    if object.send("#{attribute_name}?")
      # append preview image to output
      out << link_to(object.send("#{attribute_name}_file_name", object.send(attribute_name).url, class: 'link')
    end
    # append file input. it will work accordingly with your simple_form wrappers
    (out << @builder.file_field(attribute_name, input_html_options)).html_safe
  end
end