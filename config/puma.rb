# Puma configuration file for Heroku

# Specifies the `threads` configuration.
# Puma will run a number of threads to handle requests in parallel.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Get the environment setting from the environment variable (defaults to 'development')
rails_env = ENV.fetch("RAILS_ENV") { "development" }

# Set worker settings for production
if rails_env == "production"
  # Set the number of worker processes (one per CPU core) based on the `WEB_CONCURRENCY` environment variable.
  worker_count = Integer(ENV.fetch("WEB_CONCURRENCY") { 2 })  # Adjust this as needed (typically 2-4 for Heroku)
  
  if worker_count > 1
    # Enable multiple workers
    workers worker_count
  else
    # Preload the application to save memory (recommended in production with single worker)
    preload_app!
  end
end

# Set worker timeout (needed for longer requests in development)
worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

# Specify the port for Puma to listen on
# Heroku assigns a port dynamically, and this setting ensures that Puma uses it.
port ENV.fetch("PORT") { 3000 }

# Set the environment for Puma to run in (development, production, etc.)
environment rails_env

# Set the path for the PID file (can be customized or left default)
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Allow Puma to be restarted by the `bin/rails restart` command
plugin :tmp_restart

# Explicitly bind Puma to the dynamic port set by Heroku
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 3000 }}"
