#!/bin/bash

MANIFEST=$1

if [ -z "$1" ]
then
	echo "Defaulting to 'manifests/production.pp'"
	MANIFEST="production"
fi

puppet apply --modulepath '/etc/puppet/modules:/tmp/puppet/modules' \
	--hiera_config=/tmp/puppet/hiera/config/production.yaml \
	--detailed-exitcodes "/tmp/puppet/manifests/$MANIFEST.pp"
