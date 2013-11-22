#!/bin/bash

PWD=$(pwd)
DIR=$( dirname "${BASH_SOURCE}" )
BASE_PATH="$PWD/$DIR/.."

echo "Starting install process ..."
cd "$BASE_PATH"
echo "Installing necessary ruby gems with bundler ..."
bundle install
echo "Installing necessary puppet modules from the forge ..."
bundle exec librarian-puppet install
echo "Setting up vagrant. Hang tight. This may take a while ..."
vagrant up
cd "$PWD"
echo "All done!"
