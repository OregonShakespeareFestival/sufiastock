#!/bin/bash
cd /rails
rake db:seed
bundle exec unicorn -E production -D -p 8080
nginx
redis-server &
QUEUE=* rake resque:work
