require 'bundler/capistrano'
load 'deploy/assets'
require 'hipchat/capistrano'
load 'config/recipes/dev'
load 'config/recipes/release'
load 'config/recipes/staging'
load 'config/recipes/production'




