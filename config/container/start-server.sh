#!/bin/bash
cd /rails
rake db:seed
bundle exec unicorn -c /rails/config/container/unicorn.rb -E production
nginx -c /rails/config/container/nginx.conf -g "pid /rails/tmp/pids/nginx.pid;"
redis-server
