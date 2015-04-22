#Unicorn Config Modifed by Krug
#from digital ocean
#https://www.digitalocean.com/community/tutorials/how-to-deploy-rails-apps-using-unicorn-and-nginx-on-centos-6-5

# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/rails"
#
# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/rails/unicorn.pid"
#
# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/rails/log/unicorn.err.log"
stdout_path "/rails/log/unicorn.log"
#
# Unicorn socket
listen "/rails/unicorn.sufia.sock"
#
# Number of processes
worker_processes 4
#
# Time-out
timeout 600

@resque_pid = nil

before_fork do |server, worker|
  @resque_pid ||= spawn("bundle exec /usr/local/bin/rake " + \
  "resque:work QUEUES=*")
end

