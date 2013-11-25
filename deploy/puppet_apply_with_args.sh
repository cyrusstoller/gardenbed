#!/bin/bash

puppet apply --modulepath '/etc/puppet/modules:/tmp/puppet/modules' --hiera_config=/tmp/puppet/hiera/config/production.yaml --manifestdir /tmp/puppet/manifests --detailed-exitcodes /tmp/puppet/manifests/site.pp