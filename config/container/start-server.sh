#!/bin/bash
cd /rails
rake db:seed
bundle exec unicorn -c /rails/config/container/unicorn.rb -E production
nginx
redis-server
