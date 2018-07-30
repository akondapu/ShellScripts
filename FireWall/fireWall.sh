#!/bin/bash

# Check firewall running state
firewall-cmd --state

# Fire wall version
echo "Fire Wall Version `firewall-cmd --version`"


# Checking Network Access for Incoming NTP using the command line
less /etc/sysconfig/system-config-firewall

# List of active zones & interfaces currently assigned to them
firewall-cmd --get-active-zones

# List services currently loaded 
firewall-cmd --get-service

# 