module PopupsHelper

  def element_with_popup(opts={}, &block)
    _nested_name = uniq_popup_name.dup
    content_tag(:span, class: "_no-styles #{_nested_name}") do
      yield
    end +
    react_popup_component('ReactPopupComponent', {parent: ".#{_nested_name}", body: 'adas'})
  end

  private

  def uniq_popup_name
    "js-ui-with-popup-id-#{Time.now.to_f.to_s.gsub('.', '')}"
  end

end