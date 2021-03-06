#!/usr/bin/env bash

HOSTNAME=soberbot94-instance

function setHostname () {
	hostnamectl set-hostname ${HOSTNAME}
	echo ${HOSTNAME} > /etc/hostname
	sed -i "s/\([0-9]*.[0-9]*.[0-9]*.[0-9]*[ ]\)\([a-z]*[ ]*\)\([a-z]*[0-9]*-[a-z]*\)*/127.0.0.1 localhost ${HOSTNAME}/g" /etc/hosts
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

function installPipRequirements () {
	sudo -H python3 -m pip install yml
}

if [[ ${BASH_SOURCE[0]} == ${0} ]]; then
	setHostname
	updatePackages
	installPython3
	installOpenstackClient
	installPipRequirements
fi
