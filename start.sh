#!/bin/bash

set -e

CONFIG_DIR=/config
SETTINGS=$CONFIG_DIR/settings.json
TRANSMISSION=/usr/bin/transmission-daemon

if [[ ! -z /config/settings.json ]]; then
	cp /etc/transmission-daemon/settings.json /config/
	if [ -z $PASSWORD ]; then
		echo "No password provided in -e PASSWORD= during the docker run command. Using default password 'transmission'"
	else
		sed -i.bak -e "s/@password@/$PASSWORD/" $SETTINGS
	fi
fi

unset PASSWORD

exec $TRANSMISSION -f --no-portmap --config-dir $CONFIG_DIR --log-info 


