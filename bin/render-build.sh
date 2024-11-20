#!/usr/bin/env bash

set -o errexit  # Exit on error

# Install dependencies
bundle install

# Precompile assets
bundle exec rake assets:precompile

# Run database migrations
bundle exec rake db:migrate
