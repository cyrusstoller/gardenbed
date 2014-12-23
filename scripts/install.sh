#!/bin/bash

DIR=$( dirname "${BASH_SOURCE}" )
BASE_PATH="$DIR/.."

# Configuration from common.yaml

if [ -e "$BASE_PATH/hiera/common.yaml" ]
then
  echo "Using configurations set in 'hiera/common.yaml'"
else
  echo "Creating a 'hiera/vagrant.yaml' based on 'hiera/common.yaml.example' ..."
  cp "$BASE_PATH/hiera/common.yaml.example" "$BASE_PATH/hiera/vagrant.yaml"
  echo "Feel free to edit configurations after this bootstrap process"
  echo "To enable these new configurations call 'scripts/update.sh'"
fi

exec "$DIR/install_modules.sh"

echo "Setting up vagrant. Hang tight. This may take a while ..."
vagrant up
echo "All done!"
