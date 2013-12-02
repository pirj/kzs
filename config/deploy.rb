load 'deploy/assets'

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "kzs"
set :deploy_via, :remote_cache
set :use_sudo, false

