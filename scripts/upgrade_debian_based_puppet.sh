#!/bin/bash

# based on http://docs.puppetlabs.com/guides/installation.html#installing-puppet-1

apt-get install --yes lsb-release
DISTRIB_CODENAME=$(lsb_release --codename --short)
DEB="puppetlabs-release-${DISTRIB_CODENAME}.deb"
DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list" # Assume that this file's existence means we have the Puppet Labs repo added

if [ ! -e $DEB_PROVIDES ]
then
  # Print statement useful for debugging, but automated runs of this will interpret any output as an error
  print "Could not find $DEB_PROVIDES - fetching and installing $DEB"
  wget -q http://apt.puppetlabs.com/$DEB
  sudo dpkg -i $DEB
fi

sudo apt-get update
sudo apt-get install --yes puppet

# # to specify a specific version use http://www.debian.org/doc/manuals/apt-howto/ch-apt-get.en.html
# sudo apt-get install --yes puppet=3.3.2