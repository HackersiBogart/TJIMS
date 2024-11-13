#!/usr/bin/env bash

# Install dependencies
bundle install

# Precompile assets
bundle exec rake assets:precompile

# Run database migrations
bundle exec rake db:migrate
