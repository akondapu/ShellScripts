#!/bin/bash
    
## Ask the user for their AD creds ##
echo enter your ad ID 
read name

echo creating user $name .....
useradd $name

echo enter your ad password
passwd $name




## Ask for department ## 

echo Enter the department?
read deptname

realm join ad.fiu.edu --user=$name --computer-ou="OU=Unix-Linux,OU=$deptname,OU=Computers,OU=College of Arts Sciences & Education,OU=FIU Departments,DC=ad,DC=fiu,DC=edu" -v




## Replace the old sssd.conf with new ##
mv /etc/sssd/sssd.conf /etc/sssd/sssd.conf.bak
cp ./sssd.conf /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf




## Stopping and enabling services ##

echo mending the service .......

service sssd stop

authconfig --enablesssd --update

authconfig --enablesssd --update --enablesssdauth

service sssd start
