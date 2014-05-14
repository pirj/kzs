source 'https://rubygems.org'

gem 'rails', '~> 4.1.1'
gem 'pg'

# ActiveRecord Query DSL
gem "squeel", :git => "git://github.com/activerecord-hackery/squeel.git"
# Search object processor
gem "polyamorous", :github => "activerecord-hackery/polyamorous"
gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.1"
gem 'execjs'

gem 'paperclip', '~> 3.0'
gem 'devise'


gem 'russian', '~> 0.6.0'

gem 'populator'
gem 'faker'

# Authorization rules
gem 'cancan'

# ActiveRecord object duplication DSL
gem 'amoeba'

gem 'mustache'
gem 'smt_rails'
gem 'activeadmin', github: 'gregbell/active_admin'
gem 'awesome_nested_set'

gem 'haml'
gem 'slim'

# Form Builders
gem 'nested_form'
gem 'simple_form'
# Pagination
gem 'kaminari'

# WYSIWYG Editor
gem 'ckeditor'

gem 'bootstrap-sass'

gem 'icheck-rails'

# Decorators
gem 'draper'

# Ease REST controllers creation
gem 'inherited_resources'
gem 'has_scope'
gem 'responders'

# State Machine decoupled from model itself
gem 'statesman', '~> 0.3'

# Простая стейт-машина с названиями эвентов
gem 'workflow'

# Object read/unread management
gem 'unread', '~> 0.3.1'

#gem 'date_validator'
gem 'validates_timeliness'

gem 'jquery-rails', '~> 2.3.0'

# PDF thing
gem 'prawn'
gem 'rmagick', :require => 'RMagick'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary', '0.9.9.1'

gem 'hipchat'

gem 'spreadsheet'

# просмотр pdf в красивом окне
gem 'pdfjs_rails'


group :production do
  gem 'thin'
end

group :assets do
  #gem 'tilt', '~>1.3.3'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'compass'
  gem 'compass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'
  gem 'uglifier', '>= 1.0.3'
  gem 'chosen-rails'
  gem 'font-awesome-rails'
  # gem 'turbo-sprockets-rails3'
  gem 'therubyracer'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'zeus', '0.13.4.pre2'
  gem 'quiet_assets'
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-zeus'
  gem 'guard-rubocop', require: false
  gem 'bullet'
  gem 'yard' # Для документации
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'test_after_commit'
end
