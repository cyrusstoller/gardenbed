#!/bin/bash

DIR=$( dirname "${BASH_SOURCE}" )
BASE_PATH="$PWD/$DIR/.."

echo "Starting update process ..."
cd "$BASE_PATH"
echo "Updating necessary puppet modules from the forge and private_modules directory ..."
bundle exec librarian-puppet update
echo "Provisioning vagrant. Hang tight. This may take a while ..."
vagrant provision
echo "All done!"
