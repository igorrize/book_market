# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

require 'capistrano/puma'
# Load the SCM plugin appropriate to your project:
#
# require "capistrano/scm/hg"
# install_plugin Capistrano::SCM::Hg
# or
# require "capistrano/scm/svn"
# install_plugin Capistrano::SCM::Svn
# or

load 'config/deploy.rb'


require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

install_plugin Capistrano::Puma  # Default puma tasks
install_plugin Capistrano::Puma::Workers  # if you want to control the workers (in cluster mode)
install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template

namespace :puma do
 desc 'Create Directories for Puma Pids and Socket'
 task :make_dirs do
   on roles(:app) do
     execute "mkdir #{shared_path}/tmp/sockets -p"
     execute "mkdir #{shared_path}/tmp/pids -p"
   end
 end

 before :start, :make_dirs
end

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
