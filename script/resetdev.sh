#!/bin/bash

# Usage
# script/resetdev.sh

RAILS_ENV=development bundle exec rake db:drop && \
RAILS_ENV=development bundle exec rake db:create && \
RAILS_ENV=development bundle exec rake db:migrate && \
RAILS_ENV=development bundle exec rake db:seed && \
RAILS_ENV=development bundle exec annotate --delete && \
RAILS_ENV=development bundle exec annotate && \
RAILS_ENV=development bundle exec rubocop -a && \
RAILS_ENV=test bundle exec rspec --tag=~skip && \
RAILS_ENV=development bundle exec rake zeitwerk:check && \
RAILS_ENV=development bundle exec rake stats
