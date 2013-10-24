require 'bundler/capistrano'
require 'capistrano/ext/multistage'

set :stages, %w(production staging)
set :default_stage, 'staging'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, 'mygists'
set :repository, 'git@github.com:simeonwillbanks/mygists.git'
set :deploy_to, "/var/www/#{application}"
set :branch, 'development'

set :scm, :git
set :scm_verbose, true

set :deploy_via, :remote_cache
set :use_sudo, true
set :keep_releases, 3
set :user, 'deployer'

set :bundle_without, [:development, :test]

set :rake, "#{rake} --trace"

set :default_environment, {
  'PATH' => '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
}

after 'deploy:setup' do
  sudo "chown -R #{user} #{deploy_to} && chmod -R g+s #{deploy_to}"
end

before 'deploy:create_symlink', 'deploy:assets:precompile'

namespace :deploy do
  desc <<-DESC
  Send a USR2 to the unicorn process to restart for zero downtime deploys.
  runit expects 2 to tell it to send the USR2 signal to the process.
  DESC
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sv 2 /home/#{user}/service/#{application}"
  end
end
