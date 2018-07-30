#!/bin/bash


# Show / manipulate routing, devices, policy routing and tunnels
ip -c address


# Open tcp ports
iptables -L -n | grep tcp

# Open udp ports 
iptables -L -n | grep tcp


