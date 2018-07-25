#!/bin/bash
# Author:               Chaitanya Mundhe
# Department:           CASTIC-LINUX
# Last Revision:        07.24.2018
# About:                Shell Script installs dependent packages, create local user, and adds
#                       system to FIUs active directory.
# Resources:  
# https://www.linuxtechi.com/integrate-rhel7-centos7-windows-active-directory/

#'ScriptInformation'
    
echo "######## Add conputer to AD, press G when ready ########"
read var
if [ "$var" = "G" ] || [ "$var" = "g" ]
then
## Ask the user for their AD creds ##
 echo "######## Enter your ActiveDirectory ID ########"
 read name

 echo "######## Creating a Local-User $name ..... ########"
useradd $name

 echo "######## Enter your ActiveDirectory password ########"
 passwd $name

## Ask for department ## 

 echo "######## Enter the department? ########"
 read deptname

# Install the required packages

 yum install sssd realmd oddjob oddjob-mkhomedir adcli samba-common samba-common-tools krb5-workstation openldap-clients policycoreutils-python -y 

 realm join ad.fiu.edu --user=$name --computer-ou="OU=Unix-Linux,OU=$deptname,OU=Computers,OU=College of Arts Sciences & Education,OU=FIU Departments,DC=ad,DC=fiu,DC=edu" -v

## Replace the old sssd.conf with new ##
 mv /etc/sssd/sssd.conf /etc/sssd/sssd.conf.bak
 cp ./sssd.conf /etc/sssd/sssd.conf
 chmod 600 /etc/sssd/sssd.conf

## Stopping and enabling services ##

 echo "######## Mending the service ....... ########"

 service sssd stop

 authconfig --enablesssd --update

 authconfig --enablesssd --update --enablesssdauth

 service sssd start
fi

############################## Disable Login screen ############################


echo "######## Disable login list, press G when ready ########"
read var3
if [ "$var3" = "G" ] || [ "$var3" = "g" ]
then
  echo "######## Creating file ########"
  touch /etc/dconf/db/gdm.d/00-login-screen
  echo "[org/gnome/login-screen]" > /etc/dconf/db/gdm.d/00-login-screen
  echo "#Do not show the user list" >> /etc/dconf/db/gdm.d/00-login-screen
  echo "disable-user-list=true" >> /etc/dconf/db/gdm.d/00-login-screen
  echo "######## updating Dconf ########"
  dconf update
fi
