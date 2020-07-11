#!/bin/sh

set -e

FILE=/tmp/.ssh/id_rsa
if [ -f "$FILE" ]; then
    echo "Found $FILE."
    echo "Copying to correct path & fixing permission."
    cp -R /tmp/.ssh /root/.ssh
    chmod 700 /root/.ssh    
    chmod 600 /root/.ssh/id_rsa
fi

ansible-playbook "$@"