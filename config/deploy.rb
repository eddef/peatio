# config valid only for current version of Capistrano
lock '3.4.0'
namespace :deploy do
  on roles(:app) do
    set :application, 'peatio'
    set :repo_url, 'git@github.com:eddef/peatio.git'

    set :rvm_type, :user
    set :rvm_ruby_version, '2.2.1'
    set :rvm_custom_path, '~/.rvm'

    #set :branch, `git branch | grep "*" | sed "s/* //" | awk '{printf $0}'`

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

namespace :deploy do
  task :restart_daemons do
    `cd #{fetch(:deploy_to)}/current; /usr/bin/env rake daemons:stop daemons:start RAILS_ENV=#{fetch(:rails_env)}`
  end
end

task :restart_daemons do
  `cap #{fetch(:rails_env)} deploy:restart_daemons`
end

after :deploy, :restart_daemons

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end



end
