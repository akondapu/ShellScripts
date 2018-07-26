#!/bin/bash
# Author:               Joseph Martinez
# Department:           CASTIC-LINUX
# Last Revision:        07.24.2018
# About:                VNC installation 
# Resources: https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-remote-access-for-the-gnome-desktop-on-centos-7
# System Requirments: CentOS7 2GB RAM
# Needed: Should check if user has been created before incrementing port number. 


# Check for VNC and Install
echo "Install VNC? (Y/N)"
read var

if [ "$var" = "Y" ] || [ "$var" = "y" ]; then

  # Check for installed VNC, if installed, skip to create user
  # ADD LOGIC

  # Download VNC
  yum install -y tigervnc-server

  # File counts current port extentions
  file="/etc/systemd/system/vnc.portCount"
  if [ -f "$file" ]; then
    port=`cat /etc/systemd/system/vnc.portCount`
    echo "#### Currently opening port 590$port"
  else
    echo "#### Open first port 5901, then incrementing +1 per user" 
    touch /etc/systemd/system/vnc.portCount
    echo 1 > /etc/systemd/system/vnc.portCount
  fi

  # Check currently running VNC daemon
  echo "Displaying runnning VNC daemons..."
  systemctl status vncserver@:*
  sleep 3 

  # Generic service unit file was created /lib/systemd/system/ directory,
  # No link was made under /etc/systemd/system/ Checking...
  echo "Currrently linked VNC services created..."
  ls -l /etc/systemd/system/*.wants/vnc*

  echo "Does the user have a local account on this machine? (Y/N)"
  read answer
  input="$answer"
  while true; do

    if [ "$input" = "Y" ] || [ "$input" = "y" ]; then
      # Create new VNC daemon for user 
      echo "Making you VNC account..."
      cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:"$port".service
      
      while true; do
        echo "Please enter your AD account user name (Without .ad.fiu.edu)"
        read adAccount
        echo "Enter your account user name again..."
        read adAccountCompare

        if [ "$adAccount" == "$adAccountCompare" ]; then
          echo "#### success!"
          break
        else
          echo "##### account names do not match!"
        fi         
      done
      
      # Configure the services for the user's account name
      sed -i 's/<USER>/'$adAccount'/g' /etc/systemd/system/vncserver@:"$port".service
      
      # Reload the systemd daemon and also to make sure VNC starts up
      systemctl daemon-reload
      
      # Enable the first server instance
      systemctl enable vncserver@:"$port".service

      # Configuring the firewall
      echo "##### Adjusting firewall setting..."
      echo "Fire wall state `firewall-cmd --state`"
      echo "#### Opening port 590$port for $adAccount"
      firewall-cmd --permanent --zone=public --add-port=590"$port"/tcp
      echo "#### Reloading Fire Wall"
      sudo firewall-cmd --reload

      # Increment the port number
      nextPort=$((port+1))
      echo $nextPort > /etc/systemd/system/vnc.portCount
      echo "next client will be on Port: 590$nextPort"      

      # The user will need to log into their account to complete # vncserver
      # to make an account password 
      echo "Please contact you systems admin to complete installation..."
      echo "You will need to log in on the requesting user acount and"
      echo "run # vncserver to create a VNC password for connection."
      break
	
    elif [ "$input" = "N" ] || [ "$input" = "n"]; then
      echo "Please login with Active Directory AD account first..."
      break
  
    else
      echo "Invalid entry, please enter (Y/N)";
      read answer
    fi
  done

elif [ "$var" = "N" ] || [ "$var" = "n" ]; then
  echo "Exiting installation"

fi
