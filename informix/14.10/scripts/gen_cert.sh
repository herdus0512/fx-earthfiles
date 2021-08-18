#!/bin/bash

# Generate the certs
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out client.crt -keyout client.key -subj "/CN=${SDKMS_INFORMIX_APP_ID}"
cat client.crt | sed '1,1d' | sed '$ d' > client.crt.nohead
cat client.crt client.key > client.pem
CERT_INFO=`cat client.crt.nohead | tr -d '[:space:]'`

# Install the cert in SDKMS
SDKMS_API_KEY=`curl -s -X POST -u ${SDKMS_API_USERNAME}:${SDKMS_API_PASSWORD} https://${SDKMS_API_ENDPOINT}/sys/v1/session/auth | jq -r '.access_token'`
curl -s -X POST -H "Authorization:Bearer $SDKMS_API_KEY" -d "{\"acct_id\":\"${SDKMS_ACCT_ID}\"}" https://${SDKMS_API_ENDPOINT}/sys/v1/session/select_account
curl -s -X PATCH -H "Authorization:Bearer $SDKMS_API_KEY" -d "{\"credential\":{\"certificate\":\"$CERT_INFO\"}}" https://${SDKMS_API_ENDPOINT}/sys/v1/apps/${SDKMS_INFORMIX_APP_ID}
curl -s -X POST -H "Authorization:Bearer $SDKMS_API_KEY" https://${SDKMS_API_ENDPOINT}/sys/v1/session/terminate
