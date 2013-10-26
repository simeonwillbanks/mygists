set :server_ip, "162.243.36.36"
server server_ip, :app, :web, :primary => true
set :rails_env, 'production'
set :branch, 'master'
