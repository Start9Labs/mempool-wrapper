#!/bin/bash

set -ea

if [ $1 = "from" ]; then 
    yq -i '.advanced.peers.addnode |= map(select(.hostname != ~))' /root/.bitcoin/start9/config.yaml
    yq -i '.advanced.bloomfilters.peerbloomfilters = false' /root/.bitcoin/start9/config.yaml
    echo '{"configured": true }'
    exit 0
elif [ $1 = "to" ]; then
    yq -i 'del(.advanced.bloomfilters)' /root/.bitcoin/start9/config.yaml
    echo '{"configured": false }'
    exit 0
else
    echo "FATAL: Invalid argument: {from, to}. Migration failed." >&2
    exit 1
fi