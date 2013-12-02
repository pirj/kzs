require 'rvm/capistrano'
require 'bundler/capistrano'
load 'config/recipes/base'
load 'config/recipes/monit'



server "5.178.80.26", :web, :app, :db, primary: true
set :application, "kzs"


default_run_options[:pty] = true
ssh_options[:forward_agent] = true


task :copy_database_config do
   db_config = "#{shared_path}/database.yml"
   run "cp #{db_config} #{latest_release}/config/database.yml"
end

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end

namespace(:thin) do
  task :stop do
    run "thin stop -C /etc/thin/kzs.yml"
   end
  
  task :start do
    run "thin start -C /etc/thin/kzs.yml"
  end

  task :restart do
    run "thin restart -C /etc/thin/kzs.yml"
  end
end

namespace :deploy do
  task :setup_solr_data_dir do
    run "mkdir -p #{shared_path}/solr/data"
  end
end

before "deploy:assets:precompile", "copy_database_config"
after "deploy", "deploy:cleanup"