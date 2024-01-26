#!/bin/bash

# Usage
# script/resetdb.sh

RAILS_ENV=development bundle exec rake db:drop && \
RAILS_ENV=development bundle exec rake db:create && \
RAILS_ENV=development bundle exec rake db:migrate && \
RAILS_ENV=development bundle exec rake db:seed
