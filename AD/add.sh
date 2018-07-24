#!/bin/bash
    
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
