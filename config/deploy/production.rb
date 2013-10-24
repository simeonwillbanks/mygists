set :server_ip, ENV["VPS_IP"]
server server_ip, :app, :web, :primary => true
set :rails_env, 'production'
set :branch, 'master'
