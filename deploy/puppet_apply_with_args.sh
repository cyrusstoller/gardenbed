#!/bin/bash

puppet apply --modulepath '/etc/puppet/modules:/tmp/puppet/modules' --hiera_config=/tmp/puppet/hiera/config/production.yaml --detailed-exitcodes /tmp/puppet/manifests/production.pp