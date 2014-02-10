module Documents::ResourceHelper
  def sortable(column, title = nil)
    title ||= resource_class.human_attribute_name(attr)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page=>nil), {:class => css_class}
  end

  def render_attr resource, attr
    value=resource.public_send(attr)
    value.blank? ? I18n.t('attributes.empty') : value
  end
end
