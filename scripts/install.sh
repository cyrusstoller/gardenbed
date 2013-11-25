#!/bin/bash

DIR=$( dirname "${BASH_SOURCE}" )
BASE_PATH="$DIR/.."

# Configuration from common.yaml

if [ -e "$BASE_PATH/hiera/common.yaml" ]
then
  echo "Using configurations set in 'hiera/common.yaml'"
else
  echo "Creating a 'hiera/common.yaml' based on 'hiera/common.yaml.example' ..."
  cp "$BASE_PATH/hiera/common.yaml.example" "$BASE_PATH/hiera/common.yaml"
  echo "Feel free to edit configurations after this bootstrap process"
  echo "To enable these new configurations call 'scripts/update.sh'"
fi

# Installing dependencies

echo "Starting install process ..."
cd "$BASE_PATH"
echo "Installing necessary ruby gems with bundler ..."
bundle install
echo "Installing necessary puppet modules from the forge ..."
bundle exec librarian-puppet install
echo "Setting up vagrant. Hang tight. This may take a while ..."
vagrant up
echo "All done!"
