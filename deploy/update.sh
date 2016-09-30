#!/bin/bash

HOST=$1
MANIFEST=$2
DESTINATION=$3
DIR=$( dirname "${BASH_SOURCE}" )

function invalid_usage {
	echo
	echo "Invalid usage of update.sh"
	echo "You need to provide a destination"
	echo "usage: $0 HOST [MANIFEST] [DESTINATION]"
	echo
	exit 1
}

function call_rsync_and_place_common {
	"${DIR}/rsync.sh" "$HOST:$DESTINATION"
	echo "copying common.yaml from home directory"
	ssh $HOST "cp ~/common.yaml $DESTINATION/hiera/"
	echo "applying the new configuration"
	ssh $HOST "sudo $DESTINATION/deploy/puppet_apply_with_args.sh $MANIFEST"
	echo "provisioning finished"
}

if [ -z "$3" ]
then
	DESTINATION="/tmp/puppet"
fi

if [ -n "$1" ]
then
	call_rsync_and_place_common
else
	invalid_usage
fi