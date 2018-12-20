# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "book_market"
server "185.67.2.214"
role :web, "185.67.2.214"
role :app, "185.67.2.214"
role :db,  "185.67.2.214", :primary => true

set :repo_url, 'git@github.com:igorrize/book_market.git'
set :branch, "master"
set :user, "igorrize"
set :use_sudo, false

set :default_stage, "production"

set :deploy_to, "/home/igordeploy/sites/book_market"

set :puma_threads,    [4, 16]
set :puma_workers,    0
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     {
    forward_agent: true,
    user: fetch(:user),
    keys: %w(publickey)
}
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord
set :shared_children, "#{shared_path}public/uploads"

set :ssh_options, {
  forward_agent: true,
  keys: ['~/test_deploy'],
  user: 'igordeploy',
  auth_methods: ["publickey"]
}

# set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/sockets", "tmp/cache", "public/uploads")
append :linked_files, "config/database.yml"
