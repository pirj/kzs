module Documents::ResourceHelper
  def resource_sortable(column, title = nil)
    title ||= resource_class.human_attribute_name(attr)
    icon_class = column == sort_column ? "fa fa-sort-#{sort_direction}" : 'fa fa-sort'
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to params.merge(:sort => column, :direction => direction, :page=>nil), {:class => 'link link-success link-nounderline'} do
      content_tag(:span, title)+
      content_tag(:span, nil, class: "fa #{icon_class}")
    end.html_safe
  end

  def render_attr resource, attr
    value=resource.public_send(attr)
    value.blank? ? I18n.t('attributes.empty') : value
  end
end
