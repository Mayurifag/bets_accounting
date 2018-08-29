# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :git_hosting, 'git@gitlab.com'
set :git_username, 'Mayurifag'
set :application, 'bets_accounting'
set :repo_url, "#{fetch(:git_hosting)}:#{fetch(:git_username)}/#{fetch(:application)}.git"
set :user, 'deployer'

set :deploy_to,       "/home/#{fetch(:user)}/applications/#{fetch(:application)}"
set :ssh_options,     forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub]
set :pty, false

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :config_example_suffix, '.example'

# capistrano3-puma
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"

set :puma_init_active_record, true
# set :puma_preload_app, true

set :linked_files, %w{.rbenv-vars}
set :linked_dirs, %w{node_modules log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# namespace :deploy do
#   desc 'Run rake yarn:install'
#   task :yarn_install do
#     on roles(:web) do
#       within release_path do
#         execute("cd #{release_path} && yarn install")
#       end
#     end
#   end
# end

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      execute "#{fetch(:rbenv_prefix)} pumactl -P /home/#{fetch(:user)}/applications/#{fetch(:application)}/current/tmp/pids/puma.pid phased-restart"
    end
  end

  after 'deploy:publishing', 'deploy:restart'
  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
end