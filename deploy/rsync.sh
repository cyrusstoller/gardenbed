#!/bin/bash

DESTINATION=$1
TMP_DIRECTORY=`mktemp -d -t gardenbed_puppet`

function invalid_usage {
  echo
  echo "Invalid usage of rsync.sh"
  echo "You need to provide a destination"
  echo "usage: $0 DESTINATION"
  echo
  exit 1
}

function add_files_to_tmp_directory {
	DIR=$( dirname "${BASH_SOURCE}" )
	BASE_PATH="$DIR/.."

	cp -r "$BASE_PATH/deploy" $TMP_DIRECTORY

	cp -r "$BASE_PATH/hiera" $TMP_DIRECTORY
	rm "${TMP_DIRECTORY}/hiera/common.yaml"* # Copy over common.yml files separately

	cp -r "$BASE_PATH/manifests" $TMP_DIRECTORY
	cp -r "$BASE_PATH/modules" $TMP_DIRECTORY
	cp -r "$BASE_PATH/scripts" $TMP_DIRECTORY
}

function rsync_tmp_directory {
	du -h -d 1 $TMP_DIRECTORY

	echo "rsyncing puppet manifests to: ${DESTINATION}"
	echo ">> rsync -r ${TMP_DIRECTORY} ${DESTINATION}"

	rsync -r $TMP_DIRECTORY/* $DESTINATION

	rm -rf $TMP_DIRECTORY
}

if [ -n "$1" ]
then
	add_files_to_tmp_directory
	rsync_tmp_directory
	echo "All done!"
else
	invalid_usage
fi