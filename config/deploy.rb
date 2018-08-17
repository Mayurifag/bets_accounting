# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'bets_accounting'
set :repo_url, 'git@gitlab.com:Mayurifag/bets_accounting.git'
set :user, 'deployer'

set :deploy_to,       "/home/#{fetch(:user)}/applications/#{fetch(:application)}"
set :ssh_options,     forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub]
set :pty, false

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip

# capistrano-dotenv
set :env_file, ".env_#{fetch(:stage)}"

set :config_example_suffix, '.example'

# set :nginx_template, "#{stage_config_path}/#{fetch :stage}/nginx.conf.erb"

# capistrano3-puma
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
# set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_init_active_record, true
# set :puma_preload_app, true

# TODO: move to production
# set :linked_files, fetch(:linked_files, []).concat(%w{.env.production})
set :linked_dirs, fetch(:linked_dirs, []).concat(%w{node_modules log tmp/pids tmp/cache tmp/sockets vendor/bundle})

# after 'deploy:updated', 'assets:precompile'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
#
# namespace :puma do
#   desc 'Create Directories for Puma Pids and Socket'
#   task :make_dirs do
#     on roles(:app) do
#       execute "mkdir #{shared_path}/tmp/sockets -p"
#       execute "mkdir #{shared_path}/tmp/pids -p"
#       execute "mkdir #{shared_path}/tmp/log -p"
#     end
#   end
#
#   before :start, :make_dirs
# end
#

# namespace :deploy do
#   desc "Make sure local git is in sync with remote."
#   task :check_revision do
#     on roles(:app) do
#       unless `git rev-parse HEAD` == `git rev-parse origin/master`
#         puts "WARNING: HEAD is not the same as origin/master"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#   end
#
#   desc 'Initial Deploy'
#   task :initial do
#     on roles(:app) do
#       before 'deploy:restart', 'puma:start'
#       invoke 'deploy'
#     end
#   end
#
#   desc 'Restart application'
#   task :restart do
#     on roles(:app), in: :sequence, wait: 5 do
#       # invoke 'puma:restart'
#       # execute "/home/iconchai/.rbenv/shims/pumactl -P /home/iconchai/icon-chai/shared/pids/puma.pid phased-restart"
#       execute 'sudo restart puma-manager'
#       execute 'sudo service nginx restart'
#     end
#   end
#
#   before :starting,     :check_revision
#   after  :finishing,    :compile_assets
#   after  :finishing,    :cleanup
#   after  :finishing,    :restart
# end

namespace :deploy do
  desc 'Run rake yarn:install'
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install")
      end
    end
  end
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  # before 'deploy:migrate', 'deploy:db:create'
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  # after  :finishing,    :restart
end

# namespace :deploy do
#
#   # after 'puma:smart_restart', 'nginx:restart'
# end
