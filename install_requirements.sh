#!/usr/bin/env bash

function setHostname () {
	hostnamectl set-hostname soberbot94-instance
	echo "soberbot94-instance" > /etc/hostname
	sed -i 's/\([0-9]*.[0-9]*.[0-9]*.[0-9]*[ ]\)\([a-z]*[ ]*\)\([a-z]*[0-9]*-[a-z]*\)*/127.0.0.1 localhost soberbot94-instance/g' /etc/hosts
	systemctl restart systemd-logind.service 
}

function updatePackages () {
	apt-get -y update
	apt-get clean
}

function installPython3 () {
	apt-get -y install python3 python3-pip
	python3 -m pip install --upgrade pip
}

function installOpenstackClient () {
	add-apt-repository -y cloud-archive:pike
	apt-get -y update && apt-get -y dist-upgrade
	apt-get -y install python-openstackclient
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then
	setHostname
	updatePackages
	installPython3
	installOpenstackClient
fi
