module Library
  module RenderSectionsHelper

    def render_library_section(name)
      out = []
      paths_to_files = Dir.glob("app/views/library/#{name}/*")
      out << render_section_index(paths_to_files)
      out << render_section_files(paths_to_files)
      out.join.html_safe
    end

    protected

    # генериурем имя partial, который будет рисоваться
    # генерируем из пути к файлу, поэтому отрезаем лишние символы, чтобы сделать render 'partial_name'
    def partial_name_from(path)
      if path
        path.gsub!('app/views/', '').
            gsub!('/_', '/').
            gsub!(/(.html)+[(.erb)(.slim)(.haml)]+\b/, '')
      end
    end

    # рендерим главный файл с описанием
    # он называется _index
    def render_section_index(files_path)
      partial_path = files_path.select{|p| p.include?('index')}.first
      if partial_path
        render partial_name_from partial_path
      end
    end

    def render_section_files(files_path)
      files_path = files_path.reject{|p| p.include?('index')}
      files_path.map do |partial_path|
        render partial_name_from partial_path
      end.join.html_safe
    end
  end
end
