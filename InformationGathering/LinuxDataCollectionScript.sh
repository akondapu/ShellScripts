#!/bin/bash

function getGenericInformation() {
	diskSpace=`df -hT`
	cpuInfo=`lscpu`
	memoryInfo=`free -th | grep -B1 Mem`
	arch=`uname -p`
	ipAddresses=`ip addr | grep -A1 ether | tr -s ' '| cut -d' ' -f3,8,9 | tr '\n' ' ' | cut -d' ' -f 1-`
	userAndGroupAccounts=`cat /etc/passwd | grep '/home' | cut -d':' -f1 | while read x;do groups $x; done`
	firewallSettings=`iptables -L`
	printf "Computer Name= %s \n\nOS Type= %s \n\nOS Version= %s \n\nDisk Usage= %s \n\nCPU Info= %s \n\nMemory Information= %s \n\nArchitecture= %s \n\nIP Addresses and Mac= %s \n\nUser and Groups= %s \n\nFIrewall Settings= %s \n\n" "$computerHostName" "$osName" "$osVersion" "$diskSpace" "$cpuInfo" "$memoryInfo" "$arch" "$ipAddresses" "$userAndGroupAccounts" "$firewallSettings" >> ${computerHostName}".txt"
}

function getUbuntuSpecificInformation() {

	installedPackages=`dpkg --get-selections | grep -v deinstalled`
	printf "Software Packages Installed= %s \n\n" "$installedPackages" >> ${computerHostName}'.txt'
	
	servicesList=`initctl list`
	printf "Services List= %s" "$servicesList" >> ${computerHostName}'.txt'
}


function getCentosSpecificInformation() {

	installedPackages=`rpm -qa | sort`
	printf "Software Packages Installed= %s \n\n" "$installedPackages" >> ${computerHostName}'.txt'
	
	osVersionSpecific=`echo $osVersion | tr -d '"'| cut -d' ' -f1 `
	if [ $osVersionSpecific -eq 7 ];then
		servicesList=`systemctl list-units --type=service`
		printf "Services List= %s" "$servicesList" >> ${computerHostName}'.txt'
	else
		servicesList=`chkconfig --list`
		printf "Services List= %s" "$servicesList" >> ${computerHostName}'.txt'
	fi
}

if [ $(id -u) -eq 0 ];then

	#Get OS COmputer Name and OS Version
	osName=`cat /etc/os-release | grep '^NAME' | cut -d'"' -f2 | cut -d' ' -f1`
	computerHostName=`hostname`
	osVersion=`cat /etc/os-release | grep '^VERSION=' | cut -d'=' -f2`

	if [ $osName == 'Ubuntu' ];then

		echo "" > ${computerHostName}'.txt' 
		getGenericInformation
		getUbuntuSpecificInformation

	elif [ $osName == 'CentOS' ];then
	
		echo "" > ${computerHostName}'.txt'
		getGenericInformation
		getCentosSpecificInformation

	else
		echo "None of the above"

	fi
else
	echo "this script needs to be run as root"

fi

