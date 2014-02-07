require 'bundler/capistrano'
load 'config/recipes/base'
load 'deploy/assets'
# require 'rvm/capistrano'

#selectel
task :staging do
  server "5.178.80.26", :web, :app, :db, primary: true
  set :user, "user"
  set :application, "kzs"
  set :deploy_to, "/home/user/projects/#{application}"
  set :deploy_via, :remote_cache
  set :use_sudo, false
  set :scm, "git"
  set :repository, "git@github.com:babrovka/kzs.git"
  set :branch, "dev"

  default_run_options[:pty] = true
  ssh_options[:forward_agent] = true

  namespace :deploy do
    namespace :assets do
      task :precompile, :roles => :web, :except => { :no_release => true } do
        from = source.next_revision(current_revision)
        if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
          run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile --trace}
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

  after "deploy", "deploy:cleanup"
end


#mars
task :production do
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
  set :branch, "master"

  default_run_options[:pty] = true
  ssh_options[:forward_agent] = true

  after "deploy", "deploy:cleanup"
end


task :mercury do
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

  server "mercury.cyclonelabs.com", :web, :app, :db, primary: true

  ssh_options[:port] = 23813

  set :user, "babrovka"
  set :application, "kzs"
  set :deploy_to, "/srv/webdata/sakedev.kzsspb.ru"
  set :deploy_via, :remote_cache
  set :use_sudo, false

  set :scm, "git"
  set :repository, "git@github.com:babrovka/kzs.git"
  set :branch, "dev"

  default_run_options[:pty] = true
  ssh_options[:forward_agent] = true


  namespace :deploy do
    namespace :assets do
      task :precompile, :roles => :web, :except => { :no_release => true } do
        from = source.next_revision(current_revision)
        if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
          run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile --trace}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
      end
    end
  end
  
  namespace(:uwsgi) do
    task :restart do
      run "sudo /home/babrovka/scripts/uwsgiRestart"
    end
  end
  
  namespace(:populate) do
    task :permissions do
      run %Q{cd #{latest_release} && bundle exec rake csv:import_permissions RAILS_ENV=production}
    end
  end
  
  namespace(:populate) do
    task :users do
      run %Q{cd #{latest_release} && bundle exec rake csv:users RAILS_ENV=production}
    end
  end
  
  namespace(:populate) do
    task :organizations do
      run %Q{cd #{latest_release} && bundle exec rake csv:organizations RAILS_ENV=production}
    end
  end
  
  namespace(:populate) do
    task :documents do
      run %Q{cd #{latest_release} && bundle exec rake documents:create RAILS_ENV=production}
    end
  end
  
  after "deploy", "deploy:cleanup"
end