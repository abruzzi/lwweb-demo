# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'liked'
set :repo_url, 'git@github.com:abruzzi/testable-js-listing.git'

set :deploy_to, "/var/apps/liked"
set :unicorn_conf, "#{deploy_to}/current/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/current/tmp/pids/unicorn.pid"

set :default_env, { 'PATH' => '/opt/rbenv/shims:/opt/rbenv/bin:$PATH' }

# set :log_level, :debug
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

# Where will it be located on a server?

set :env, "development"

# Unicorn control tasks
namespace :deploy do

  task :restart do
  	on roles(:all) do |host|
  		execute "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{env} -D; fi"
  	end    
  end

  task :start do
  	on roles(:all) do |host|
      execute "cd #{deploy_to}/current"
      execute "rbenv exec bundle install --path vendor"
  		execute "bundle exec unicorn -c #{deploy_to}/current/unicorn.rb -E development -D"
  	end
  end

  task :stop do
    execute "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

end

