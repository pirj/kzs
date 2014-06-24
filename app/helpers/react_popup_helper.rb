module ReactPopupHelper

  # Render a specific UJS-type HTML tag annotated with data attributes, which
  # are used by react_popup_ujs to actually instantiate the React component
  # on the client.
  #
  # Will render in special popup area.
  def react_popup_component(name, args = {}, options = {}, &block)
    options = {:tag => options} if options.is_a?(Symbol)
    block = Proc.new { React::Renderer.render(name, args) } if options[:prerender] == true

    html_options = options.reverse_merge(:data => {})
    html_options[:data].tap do |data|
      data[:react_popup_class] = name
      data[:react_popup_props] = args.to_json unless args.empty?
    end
    html_tag = html_options.delete(:tag) || :div

    content_for :popup_layout do
      # content_tag(html_tag, '', html_options, &block)
      content_tag(html_tag) do
        html_options
      end
    end
  end

end