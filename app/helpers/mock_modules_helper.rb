module MockModulesHelper


  # вставляем изображение-превью несуществующего модуля
  def mock_presentation_img(img_name)
    content_tag :div, class: 'row' do
      content_tag :div, class: 'col-sm-12' do
        image_tag "mock_modules/#{img_name}", class: '_mock-module-img'
      end
    end
  end

end