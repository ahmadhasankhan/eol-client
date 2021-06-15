#!/bin/bash
export RAILS_ENV=test
export COVERAGE=true

bundle install

if [[ -d coverage ]]; then
  echo "Removing old coverage report"
  rm -r coverage
fi

echo "--- Check style"

rubocop

if [[ $? -ne 0 ]]; then
  echo "--- Style checks failed."
  exit 1
fi

echo "--- Doing a static analysis"

rubycritic app lib config

echo "--- Running RSpec"

rspec --color spec --format progress --format html --out rspec.html
rspec=$?

if [[ $rspec -ne 0 ]]; then
  echo "--- Some tests have failed."
  exit 1
fi
