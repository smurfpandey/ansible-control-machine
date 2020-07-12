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

if [ -z "$VAULT_PASS" ]; then
    echo "Skipping vault password file creation."
else
    VAULT_PASS_FILE=/tmp/ansible_vault_pass
    echo "Creating vault password file at $VAULT_PASS_FILE."
    echo $VAULT_PASS >> $VAULT_PASS_FILE    
fi

ansible-playbook "$@"