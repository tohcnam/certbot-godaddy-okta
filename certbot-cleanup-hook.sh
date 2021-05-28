#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/certbot-settings.sh

TYPE=TXT
NAME="_acme-challenge"
DATA="$CERTBOT_VALIDATION"

curl    -s \
        -X PUT \
        "${GODADDY_URL}/v1/domains/${CERTBOT_DOMAIN}/records/${TYPE}/${NAME}" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" \
        -d "[{\"data\": \"...\", \"name\": \"${NAME}\", \"type\": \"${TYPE}\", \"ttl\": 600}]"
