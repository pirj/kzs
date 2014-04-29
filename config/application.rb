require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'yaml'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Kzs
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/app/models/concerns)
    config.autoload_paths += %W(#{config.root}/app/controllers/concerns)
    config.autoload_paths += %W["#{config.root}/lib/**/"]
    #config.autoload_paths += %W(#{config.root}/app/models/documents)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.before_configuration do
      I18n.config.enforce_available_locales = false #@prdetective TODO: this will default to true in future rails versions
      I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
      I18n.locale = :ru
      I18n.default_locale = :ru
      config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
      config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
      config.i18n.locale = :ru
      # bypasses rails bug with i18n in production\
      I18n.reload!
      config.i18n.reload!
    end

    config.i18n.locale = :ru
    config.i18n.default_locale = :ru

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true
    
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    
    # Enable the asset pipeline
    config.assets.enabled = true

    # чтобы assets правильно слипались выставить в true
    # чтобы вместо .class __subclass{}
    # было .class__subclass{}
    config.assets.initialize_on_precompile = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.assets.precompile += %w(library.js library.css active_admin.css active_admin.js app.css)

    #Machinist to automatically add a blueprint to your blueprints file whenever you generate a model
    config.generators do |g|
      g.fixture_replacement :machinist
      g.test_framework :rspec
    end

    mail_conf_path = 'config/mail.yml'
    mail_config = File.exists?(mail_conf_path) ? YAML::load_file(mail_conf_path) : {}

    # TODO: move to mail.yml
    config.action_mailer.default_url_options = { host: mail_config['host'] }
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = mail_config['smtp'].try(:symbolize_keys)
  end
end
