# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server 'example.com', user: 'deploy', roles: %w{app db web}, my_property: :my_value
# server 'example.com', user: 'deploy', roles: %w{app web}, other_property: :other_value
# server 'db.example.com', user: 'deploy', roles: %w{db}

set :rails_env, 'staging'

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any  hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

role :app, %w{deploy@otc.sicanet.net}
role :web, %w{deploy@otc.sicanet.net}
role :db,  %w{deploy@otc.sicanet.net}, primary: true

set :nginx_server_name, 'otc.sicanet.net'

set :application, 'peatio'
set :repo_url, 'git@github.com:eddef/peatio.git'

set :rvm_type, :user
set :rvm_ruby_version, '2.2.1'
set :rvm_custom_path, '~/.rvm'

#set :branch, `git branch | grep "*" | sed "s/* //" | awk '{printf $0}'`

set :deploy_to, '/home/deploy/peatio-cap'

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