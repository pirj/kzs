# coding:utf-8
module Documents
  module TableFiltersHelper
    def table_filter_form
    end

    # TODO-justvitalius: а что если target сделать зависимым от search_field
    # метод для отрисовки лэйбла-кнопки в шапке таблицы, которая активирует какой-то элемент фильтровой формы
    # title — название лэйбла-кнопки
    # object — объект класса ransack, вокруг которого и строится фильтр
    # search_field — название поискового поля, к которому привязывается кнопка
    # target
    def table_filter_caption(title, object, search_field, target)
      classes = 'label label-sm js-table-filter-activate-btn'
      classes += ' label-default' unless object.try(search_field.to_sym).blank?
      content_tag :div, class: classes, data: { target: target } do
        content_tag(:span, title) +
        content_tag(:span, nil, class: 'fa fa-filter')
      end.html_safe
    end
  end
end