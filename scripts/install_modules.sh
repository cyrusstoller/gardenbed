#!/bin/bash

DIR=$( dirname "${BASH_SOURCE}" )
BASE_PATH="$DIR/.."

# Installing dependencies

echo "Starting install process ..."
cd "$BASE_PATH"

which bundle
if [ $? -eq 0 ]
then
  echo "bundler is already installed"
else
  echo "installing bundler ..."
  gem install bundler
fi

echo "Installing necessary ruby gems using bundler ..."
bundle install
echo "Installing necessary puppet modules from the forge ..."
bundle exec librarian-puppet install
