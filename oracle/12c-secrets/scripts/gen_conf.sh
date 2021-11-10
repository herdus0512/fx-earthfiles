#!/bin/bash

sed -e "s|<@@API_ENDPOINT@@>|$SDKMS_API_ENDPOINT|g" pkcs11.conf.tmpl > /etc/fortanix/pkcs11.conf
