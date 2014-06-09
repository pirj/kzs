load 'deploy/assets'
require 'bundler/capistrano'
load 'config/recipes/base'

module UseScpForDeployment
  def self.included(base)
    base.send(:alias_method, :old_upload, :upload)
    base.send(:alias_method, :upload,     :new_upload)
  end
  
  def new_upload(from, to, options = {}, &block)
  old_upload(from, to, options.merge(:via => :scp), &block)
  end
end
 
Capistrano::Configuration.send(:include, UseScpForDeployment)




server "mars.cyclonelabs.com", :web, :app, :db, primary: true

ssh_options[:port] = 33910

set :user, "babrovka"
set :application, "kzs"
set :deploy_to, "/srv/webapp/#{application}"
set :use_sudo, false

set :scm, :none
set :repository, "."
set :deploy_via, :copy
set :local_repository, "."
set :precompile_only_if_changed, true


set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true


# task :copy_database_config do
#    db_config = "#{shared_path}/database.yml"
#    run "cp #{db_config} #{latest_release}/config/database.yml"
# end

# namespace :deploy do
#   namespace :assets do
#     task :precompile, :roles => :web, :except => { :no_release => true } do
#       from = source.next_revision(current_revision)
#       if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
#         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
#       else
#         logger.info "Skipping asset pre-compilation because there were no asset changes"
#       end
#     end
#   end
# end

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      begin
        from = source.next_revision(current_revision) # <-- Fail here at first-time deploy because of current/REVISION absence
      rescue
        err_no = true
      end
      if err_no || capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
   end
  end
end


# invoke custom rake task
namespace :rake do
  desc "Invoke rake task"
  task :invoke do
    run "cd #{latest_release}"
    run "bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}"
  end
end

namespace(:uwsgi) do
  task :stop do
    run "service uwsgi stop"
   end
  
  task :start do
    run "service uwsgi stop"
  end

  task :restart do
    run "service uwsgi stop"
  end
end

# namespace :deploy do
#   task :setup_solr_data_dir do
#     run "mkdir -p #{shared_path}/solr/data"
#   end
# end

# before "deploy:assets:precompile", "copy_database_config"
after "deploy", "deploy:cleanup"