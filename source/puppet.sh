#!/bin/sh
codename=$(lsb_release -sc)
package="puppet-tools-release-${codename}.deb"
wget "https://apt.puppet.com/${package}" -P /tmp
sudo dpkg -i "/tmp/${package}"
sudo apt-get update
sudo apt-get install puppet-bolt
