#!/bin/bash

function invalid_usage {
  echo
  echo "Invalid usage of random_password.sh"
  echo
  echo "You need to provide a length to get a random_password"
  echo
  echo "usage: $0 LENGTH"
  exit 1
}

if [ -n "$1" ]
then
	RANDFILE=/dev/null openssl rand -base64 $1
else
	invalid_usage
fi