module PopupsHelper

  def element_with_popup(opts={}, &block)
    _nested_name = uniq_popup_name.dup
    popup_opts = opts.delete(:popup) || {}
    popup_opts.merge!(parent: ".#{_nested_name}")

    content_tag(:span, class: "_no-styles #{_nested_name}") do
      yield
    end +
    content_for(:popup_layout) do
      react_component('ReactPopupComponent', popup_opts)
    end
  end

  private

  def uniq_popup_name
    "js-ui-with-popup-id-#{Time.now.to_f.to_s.gsub('.', '')}"
  end

end