#!/usr/bin/env bash

current_dir=$( pwd )
home_dir=$( cd ~ && pwd )
script_dir=$( cd "$( dirname "$0" )" && pwd )

# TODO: support rbenv and rvm
# TODO: have a command-line ocular setup which uses `which` to work out what you have and where
source /usr/local/opt/chruby/share/chruby/chruby.sh

cd $1

# TODO: read from Gemfile / .ruby-version file
chruby $(cat Gemfile | grep "ruby \"" | tr -d '\n' | awk -F '"' '{print $2}')

bundle check >/dev/null 2>/dev/null || bundle install
bundle exec rspec --require="$script_dir/rspec_dry_run.rb" --format="OcularDryRunFormatter" | grep "rspec .*:.* # .*"
