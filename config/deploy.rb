load 'deploy/assets'

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'


set :deploy_via, :remote_cache
set :use_sudo, false


set :user, "user"
set :deploy_to, "/home/user/projects/#{application}"
set :scm, "git"
set :repository, "git@github.com:babrovka/kzs.git"
set :branch, "master"






