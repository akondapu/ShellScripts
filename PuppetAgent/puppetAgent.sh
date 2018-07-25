#!/bin/bash

# Author:               Joseph Martinez
# Department:           CASTIC-LINUX
# Last Revision:        07.24.2018
# About:                Shell Script installs dependent packages, create local user, and adds
#                       system to FIUs active directory.
# Resources:  
# Puppet Platform repository of open source Puppet 5-compatible software packages.
# https://puppet.com/docs/puppet/5.3/puppet_platform.html
#
# Installing Puppet agent: Linux
# https://puppet.com/docs/puppet/5.3/install_linux.html

# Enable the Puppet 5 Platform repository
rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm

# Quickly add the executable location to the PATH 
export PATH=/opt/puppetlabs/bin:$PATH

# Install Puppet Agent
yum install -y  puppet-agent

# Start the puppet service
puppet resource service puppet ensure=running enable=true

# Configure puppetmaster within hosts
echo 10.100.34.153 puppetmaster.ad.fiu.edu puppet >> /etc/hosts

# Ping Master's ip
ping -c 5 10.100.34.153

ping -c 5 puppetmaster.ad.fiu.edu

# Test puppet agent connect and ssl cert
puppet agent --test

echo "puppet agent installation complete"
echo "Run 'puppet agent -t' to receive catalog from the master"
