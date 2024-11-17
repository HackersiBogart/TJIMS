# Specifies the `threads` configuration.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

rails_env = ENV.fetch("RAILS_ENV") { "development" }

# Set worker settings for production
if rails_env == "production"
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })
  
  if worker_count > 1
    workers worker_count
  else
    preload_app!
  end
end

worker_timeout 3600 if rails_env == "development"

# Render dynamically assigns a port, set it here.
environment rails_env
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
plugin :tmp_restart

# Bind to Render's 0.0.0.0 host with the assigned port
bind "tcp://0.0.0.0:#{ENV.fetch('PORT')}"





