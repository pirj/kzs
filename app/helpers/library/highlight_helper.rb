module Library
  module HighlightHelper

    def highlight_code code
      content_tag(:div, class: 'highlight') do
        content_tag(:pre, class: 'prettyprint') do
          html_escape code
        end
      end
    end

  end
end