#!/usr/bin/env bash
# Exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails db:migrate
