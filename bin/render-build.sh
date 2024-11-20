#!/usr/bin/env bash

# Install Ruby dependencies
bundle install

# Precompile Rails assets (for CSS and other static assets)
RAILS_ENV=production bundle exec rake assets:precompile

# Run database migrations
RAILS_ENV=production bundle exec rake db:migrate
