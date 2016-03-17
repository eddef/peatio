# config valid only for current version of Capistrano
lock '3.4.0'
#namespace :deploy do
#  on roles(:app) do


#  end
#end

=begin
namespace :deploy do
  task :restart_daemons do
    `cd #{fetch(:deploy_to)}/current; /usr/bin/env rake daemons:stop daemons:start RAILS_ENV=#{fetch(:rails_env)}`
  end
end

task :restart_daemons do
  `cap #{fetch(:rails_env)} deploy:restart_daemons`
end

after :deploy, :restart_daemons

=end
