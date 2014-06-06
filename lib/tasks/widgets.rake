# coding: utf-8
namespace :widgets do
  desc "Drop saved user dashboard widgets settings"
  task drop_users_settings: :environment do
    UserDesktopConfiguration.destroy_all
  end
end