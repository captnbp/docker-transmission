#!/bin/bash

set -e

CONFIG_DIR=/config
SETTINGS=$CONFIG_DIR/settings.json
TRANSMISSION=/usr/bin/transmission-daemon

if [[ ! -f ${SETTINGS}.bak ]]; then
    if [ -z $PASSWORD ]; then
        echo Please provide a password for the 'transmission' user via the ADMIN_PASS enviroment variable.
        exit 1
    fi

    sed -i.bak -e "s/@password@/$PASSWORD/" $SETTINGS 
fi

unset PASSWORD

exec $TRANSMISSION -f --no-portmap --config-dir $CONFIG_DIR --log-info 


