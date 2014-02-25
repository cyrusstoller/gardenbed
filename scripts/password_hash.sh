#!/bin/bash

function invalid_usage {
  echo
  echo "Invalid usage of password_hash.sh"
  echo
  echo "You need to provide a username and password to get a password hash for postgres"
  echo
  echo "usage: $0 USERNAME PASSWORD"
  exit 1
}

if [ -n "$2" ]
then
	echo -n "md5"; echo -n "$2$1" | md5
else
	invalid_usage
fi