#!/bin/bash
cd /rails
rake db:seed
redis-server &
nginx -c /rails/config/container/nginx.conf -g "pid /rails/tmp/pids/nginx.pid;" &
bundle exec unicorn -c /rails/config/container/unicorn.rb -E production
