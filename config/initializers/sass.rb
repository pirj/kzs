require 'sprockets/railtie'
#Rails.application.assets.register_postprocessor 'text/css', :sass_bem_class_builder do |context, data|
#  data.gsub(/([a-zA-Z0-9\-]+)[ ]([_]+)/i){ $1 + $2 }
#end
Rails.application.assets.register_postprocessor 'text/css', :sass_bem_class_builder do |context, data|
  data.gsub(/([a-zA-Z0-9\-]+)[ ]([_]+)/i){ $1 + $2 }
end