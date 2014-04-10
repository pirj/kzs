# coding: utf-8
module Features
  module SessionsHelper

    # метод сохраняет скриншот страницы в папку test_images
    # работает только при запуске теста через js
    # имя файла формируется как
    # custom-<FILENAME>-<LINE>.png
    def create_screenshot
      if example.metadata[:js]
        meta = example.metadata
        filename = File.basename(meta[:file_path])
        line_number = meta[:line_number]
        screenshot_name = "custom-#{filename}-#{line_number}.png"
        screenshot_path = "#{Rails.root.join("test_images")}/#{screenshot_name}"
        page.save_screenshot(screenshot_path, full: true)
      end
    end

  end
end
