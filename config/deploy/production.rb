set :rails_env, 'production'

role :app, %w{exchanger@212.125.247.41}
role :web, %w{exchanger@212.125.247.41}
role :db,  %w{exchanger@212.125.247.42}, primary: true

set :nginx_server_name, '212.125.247.41'

