set -o errexit

bundle install
bundle exec rails assets:precomplile
bundle exec rails assets:clean