#!/bin/bash

ORACLE_BASE=/opt/oracle
RUN_FILE="runOracle.sh"
SDKMS_API_KEY=`cat /opt/myapp/credentials/api_key`

sed -i "s|<@@API_KEY@@>|$SDKMS_API_KEY|g" /etc/fortanix/pkcs11.conf

# Start Oracle Database.
exec $ORACLE_BASE/$RUN_FILE
