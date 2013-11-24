#!/bin/bash

function invalid_usage {
  echo
  echo "Invalid usage of bootstrap.sh"
  echo
  echo "You need to provide a bootstrap environment as an argument"
  echo "valid options include: 'development', 'staging'"
  echo
  echo "usage: $0 BOOTSTRAP_ENVIRONMENT"
  exit 1
}

DIR=$( dirname "${BASH_SOURCE}" )
BASE_PATH="$DIR/.."

# Get first argument

case $1 in
  development)
    echo "Starting development bootstrap process ..."
    cp "$BASE_PATH/Vagrantfile.development" "$BASE_PATH/Vagrantfile"
    ;;
  staging)
    echo "Starting staging bootstrap process ..."
    cp "$BASE_PATH/Vagrantfile.staging" "$BASE_PATH/Vagrantfile"
    ;;
  *)
    invalid_usage
    ;;
esac

exec "$DIR/install.sh"