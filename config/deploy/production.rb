
set :rails_env, 'production'

role :app, %w{exchanger@212.125.247.41}
role :web, %w{exchanger@212.125.247.41}
role :db,  %w{exchanger@212.125.247.42}, primary: true

set :nginx_server_name, '212.125.247.41'

namespace :deploy do
  on role(:app) do
    set :application, 'peatio'
    set :repo_url, 'git@github.com:eddef/peatio.git'

    set :rvm_type, :user
    set :rvm_ruby_version, '2.2.1'
    set :rvm_custom_path, '~/.rvm'

    set :deploy_to, '~/peatio-cap'

    set :nginx_sites_available_path, "/etc/nginx/sites-available"
    set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"

    set :linked_files, fetch(:linked_files, []).push(
        'config/database.yml',
        'config/application.yml',
        'config/currencies.yml',
        'config/markets.yml',
        'config/amqp.yml',
        'config/banks.yml',
        'puma.rb'
    )

    set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
  end
end

