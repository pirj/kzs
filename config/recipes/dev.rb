#sakedev.cyclonelabs.com 
task :dev do
  module UseScpForDeployment
    def self.included(base)
      base.send(:alias_method, :old_upload, :upload)
      base.send(:alias_method, :upload,     :new_upload)
    end
  
    def new_upload(from, to, options = {}, &block)
    old_upload(from, to, options.merge(:via => :scp), &block)
    end
  end
  
  task :copy_database_config do
     db_config = "#{shared_path}/database.yml"
     run "cp #{db_config} #{latest_release}/config/database.yml"
  end
  
  task :copy_mail_config do
     db_config = "#{shared_path}/mail.yml"
     run "cp #{db_config} #{latest_release}/config/mail.yml"
  end
  
  Capistrano::Configuration.send(:include, UseScpForDeployment)

  server "mercury.cyclonelabs.com", :web, :app, :db, primary: true

  ssh_options[:port] = 23813

  set :user, "babrovka"
  set :application, "kzs"
  set :deploy_to, "/srv/webdata/sake3.cyclonelabs.com"
  set :deploy_via, :remote_cache
  set :use_sudo, false

  set :scm, "git"
  set :repository, "git@github.com:babrovka/kzs.git"
  set :branch, "iframe_mode"

  default_run_options[:pty] = true
  ssh_options[:forward_agent] = true
  
  set :hipchat_token, "9ccb22cbbd830fcd68cf2289a4f34b"
  set :hipchat_room_name, "430075"
  set :hipchat_announce, true


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
  
  namespace(:thin) do
    task :stop do
      run %Q{cd #{latest_release} && RAILS_ENV=dev bundle exec thin stop -C #{shared_path}/sake3.yml}
     end

    task :start do
      run %Q{cd #{latest_release} && RAILS_ENV=dev bundle exec thin start -C #{shared_path}/sake3.yml}
    end

    task :restart do
      stop
      start
    end
  end
  
  
  namespace :private_pub do
    desc "Start private_pub server"
    task :start do
      # recipe from github
      # run "cd #{current_path};RAILS_ENV=production bundle exec rackup private_pub.ru -s thin -E production -D -P tmp/pids/private_pub.pid"
      run %Q{cd #{latest_release} && RAILS_ENV=dev bundle exec thin start -C #{shared_path}/private_pub.yml}
    end

    # recipes from github
    desc "Stop private_pub server"
    task :stop do
      run "cd #{current_path};if [ -f tmp/pids/private_pub.pid ] && [ -e /proc/$(cat tmp/pids/private_pub.pid) ]; then kill -9 `cat tmp/pids/private_pub.pid`; fi"
    end

    desc "Restart private_pub server"
    task :restart do
      stop
      start
    end
  end
  
  namespace(:log) do
    task :rails do
      run %Q{cd #{shared_path} && tailf -n 50 log/dev.log }
    end

    task :thin do
      run %Q{cd #{shared_path} && tailf -n 50 log/thin.log }
    end
  end
  
  namespace(:populate) do
    task :data do
      run %Q{cd #{latest_release} && bundle exec rake db:seed RAILS_ENV=dev}
    end
  end
  
  
  before "deploy:assets:precompile", "copy_database_config"
  after "copy_database_config", "copy_mail_config"
  # after "deploy", "deploy:cleanup"
end