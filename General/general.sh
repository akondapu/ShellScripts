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
