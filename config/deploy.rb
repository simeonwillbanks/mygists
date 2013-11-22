require 'bundler/capistrano'

set :stages, %w(production staging)
set :default_stage, 'staging'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV['HOME'], '.ssh', 'id_rsa')]

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

set :bundle_without, [:development, :test, :debug]

set :rake, "#{rake} --trace"

set :default_environment, {
  'PATH' => '/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH'
}

before 'deploy:create_symlink', 'deploy:assets:precompile'
after 'deploy:update_code', 'deploy:symlink_shared'
after 'deploy:finalize_update', 'deploy:restart'

namespace :deploy do
  desc <<-DESC
  Send a USR2 to the unicorn process to restart for zero downtime deploys.
  runit expects 2 to tell it to send the USR2 signal to the process.
  DESC
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sv 2 /home/#{user}/service/#{application}"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
