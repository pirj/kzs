module Library
  module RenderItemsHelper


    # подзаголовок
    # применяется для подраздела раздела в библиотеке
    def library_item_caption title
      content_tag :h3, title, id: item_uniq_id
    end

    # заголовок
    # применяется для обозначения раздела с подразделами
    def library_section_caption title
      content_tag :h2, title, id: item_uniq_id
    end

    private

    # генерирует имя,состоящее из названия папки и имени паршиала
    # к примеру паршиал находится по адресу library/headers/index
    # в итоге получаем headers_index
    def item_uniq_id
      current_path = controller.view_context.view_renderer.instance_variable_get('@_partial_renderer').instance_values['path'].inspect
      current_path.gsub!('library/', '').gsub!('/', '_')
    end

  end
end