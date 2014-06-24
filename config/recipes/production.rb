#sake.kzsspb.ru
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
  
  task :copy_database_config do
     db_config = "#{shared_path}/database.yml"
     run "cp #{db_config} #{latest_release}/config/database.yml"
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
  
  before "deploy:assets:precompile", "copy_database_config"
  after "deploy", "deploy:cleanup"
end