service nginx restart
RAILS_ENV=production bundle exec ./bin/rake daemons:stop
RAILS_ENV=production bundle exec ./bin/rake daemons:start