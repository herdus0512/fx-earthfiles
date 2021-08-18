#!/bin/bash

sed -e "s|<endpoint>|$SDKMS_API_ENDPOINT|g" kmip.json.template | sed -e "s|<keyid>|$SDKMS_INFORMIX_KEY_ID|g" > kmip.json