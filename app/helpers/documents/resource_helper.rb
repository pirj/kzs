module Documents::ResourceHelper
  def resource_sortable(column, title = nil)
    icon_class = resource_sortable_icon_class(column)
    resource_sortable_wrapper column do
      content_tag(:span, title)+
      content_tag(:span, nil, class: "fa #{icon_class}")
    end.html_safe
  end

  def resource_sortable_icon(column, title = nil)
    icon_class = resource_sortable_icon_class(column)
    resource_sortable_wrapper column do
      content_tag(:span, nil, class: "fa #{icon_class}")
    end.html_safe
  end

  def render_attr resource, attr
    value=resource.public_send(attr)
    value.blank? ? I18n.t('attributes.empty') : value
  end


  private

  def resource_sortable_wrapper(column, &block)
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to params.merge(:sort => column, :direction => direction, :page=>nil), {:class => 'link link-success link-nounderline'} do
      yield
    end.html_safe
  end

  # иконка сортировки,стрелка вверх-вниз в зависимости от ASC DESC текущей сортировки
  def resource_sortable_icon_class(column)
    column == sort_column ? "fa fa-sort-#{sort_direction}" : 'fa fa-sort'
  end
end
