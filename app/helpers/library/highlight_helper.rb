module Library
  module HighlightHelper


    # подсветка строки
    # автоматически определяем кол-во строк и рисуем номера, если строк более,чем одна
    # все скрытые html-символы для текста по ссылке http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Literals
    def highlight_code code
      lines = 'linenums' unless code.match('\n').blank?
      content_tag(:div, class: 'highlight') do
        content_tag(:pre, class: "prettyprint #{lines}") do
          html_escape code
        end
      end
    end

  end
end