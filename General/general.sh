#!/bin/bash

echo The host-name for your system is 

hostnamectl status
echo "######## Do you wish to change ? (Y/N) ########"
read var
if [ "$var" = "Y" ] || [ "$var" = "y" ]
then
  echo "######## Enter the new Host-Name ########"
  read enthost
  hostnamectl set-hostname "($enthost).ad.fiu.edu"
fi



echo "######## Do you wish to update ? (Y/N) ########"
read var2
if [ "$var2" = "Y" ] || [ "$var2" = "y" ]
then
  yum update -y
fi

echo "######## Press G, when ready for Time sync ########"
read var3
if [ "$var3" = "G" ] || [ "$var3" = "g" ]
then
  hwclock --systohc
  echo "server time.fiu.edu prefer" >> /etc/chrony.conf
  systemctl restart chronyd
  echo "Done !!"
fi
