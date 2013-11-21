#!/bin/bash

puppet apply --modulepath '/etc/puppet/modules:/tmp/vagrant-puppet/modules-0' --hiera_config=/tmp/vagrant-puppet/hiera.yaml --manifestdir /tmp/vagrant-puppet/manifests --detailed-exitcodes /tmp/vagrant-puppet/manifests/site.pp