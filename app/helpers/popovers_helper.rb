module PopoversHelper

  def element_with_popover(opts={}, &block)
    _nested_name = uniq_popup_name.dup
    popover_opts = opts.delete(:popover) || {}
    popover_opts.merge!(parent: ".#{_nested_name}")

    content_tag(:span, class: "_no-styles #{_nested_name}") do
      yield
    end +
    content_for(:popover_layout) do
      react_component('ReactPopupComponent', popover_opts)
    end
  end

  private

  def uniq_popup_name
    "js-ui-with-popup-id-#{Time.now.to_f.to_s.gsub('.', '')}"
  end

end