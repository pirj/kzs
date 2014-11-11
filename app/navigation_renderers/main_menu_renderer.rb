# Render simple-navigation manu as <li>-list with special <span> inside links.
class MainMenuRenderer < SimpleNavigation::Renderer::Base

  def render(item_container)
    if skip_if_empty? && item_container.empty?
      ''
    else
      content = list_content(item_container)
      content_tag(:ul, content, item_container.dom_attributes)
    end
  end

  private

  def list_content(item_container)
    item_container.items.map { |item|
      li_options = item.html_options.except(:link)

      # преобразовываем параметры для работы предзагруженных нотификаций
      item_options = {
        icon: li_options.delete(:icon),
        notification_text: li_options.delete(:notification_text),
        notification_color: li_options.delete(:notification_color),
        id: li_options[:id]
      }#.compact

      # пребразовываем параметры для работы модуля нотификаций
      li_options['data-module'] = li_options.delete(:module)
      li_options['data-name'] = li_options.delete(:name)

      # формируем итоговую ссылку
      li_content = tag_for(item, item_options)
      if include_sub_navigation?(item)
        li_content << render_sub_navigation_for(item)
      end
      content_tag(:li, li_content, li_options)
    }.join
  end

  # determine and return link or static content depending on
  # item/renderer conditions.
  def tag_for(item, options)
    badge_txt, badge_color = badge_params(options)
    tag_content = item_name(item.name, options[:icon], badge_txt, badge_color, options[:id] )

    if suppress_link?(item)
      # content_tag('span', item.name, link_options_for(item).except(:method))
      content_tag('span', tag_content, link_options_for(item).except(:method))
    else
      link_to(tag_content, item.url, options_for(item))
    end
  end


  # содержимое ссылки
  def item_name(name, icon, badge_txt, badge_color, badge_id)
    badge_js_class = "js-left-menu-notification-badge"
    html = []
    html << content_tag(:span, nil, class: "_left-menu__item-icon #{icon}") if icon
    html << content_tag(:span, name, class: 'text')
    html << content_tag(:span, badge_txt.to_s.gsub(/\s+/, ""), class: "badge #{badge_color} #{badge_js_class} m-left-menu")
    html << content_tag(:span, nil, class: "triangle")

    html.join.html_safe
  end


  # возвращает параметры бэйджа в формате
  # если передается хотя бы один из параметров <текст> или <цвет>
  # то параметры у бэйджа будут
  # [text, color]
  def badge_params(options)
    h = options.dup
    color = nil
    text = nil

    if h.has_key?(:notification_color) || h.has_key?(:notification_text)
      color = h[:notification_color].try(:call) || 'badge-green'
      text = h[:notification_text].try(:call) || ' '
    end

    [text, color]
  end



end

