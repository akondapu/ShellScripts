#!/bin/bash
# Installation for Sublime text editor on CentOS/RHEL 


installed=`rpm -qa | grep sublime | wc -l`
if [ "$installed" = 0 ]; then

  sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
  sudo yum-config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
  sudo yum install -y sublime-text

else
 
  echo "Software already installed!"
  echo `rpm -qa | grep sublime` 

fi
