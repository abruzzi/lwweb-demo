require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)


set :domain, '192.168.2.105'
set :deploy_to, '/var/apps/liked'
set :repository, 'git@github.com:abruzzi/testable-js-listing.git'
set :branch, 'master'

# Optional settings:
set :user, 'liked'    # Username in the server to SSH to.
set :identity_file, '/Users/jtqiu/.ssh/id_vagrant_liked'
set :forward_agent, true
set :rbenv_path, '/opt/rbenv'

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  invoke :'rbenv:load'
  queue "export PATH=/opt/rbenv/bin:/opt/rbenv/shims:$PATH"
end

task :start => :environment do
  queue! "cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E development -D"
end

task :restart => :environment do
  queue! "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{env} -D; fi"
end

task :stop => :environment do
  queue! "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
end

# Put any custom mkdir's in here for when `mina setup` is ran.
task :setup => :environment do
  queue! "mkdir -p #{deploy_to}/current/tmp/pids #{deploy_to}/current/tmp/sockets"
  queue! "mkdir -p #{deploy_to}/current/log"
end

set :unicorn_conf, "#{deploy_to}/current/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/current/tmp/pids/unicorn.pid"

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'bundle:install'
  end
end

