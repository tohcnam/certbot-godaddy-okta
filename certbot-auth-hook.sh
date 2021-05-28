#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/certbot-settings.sh

TYPE=TXT
NAME="_acme-challenge.${SUBDOMAIN}"
DATA="$CERTBOT_VALIDATION"

curl    -s \
        -X PATCH \
        "${GODADDY_URL}/v1/domains/${DOMAIN}/records" \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -H "Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}" \
        -d "[{\"data\": \"${DATA}\", \"name\": \"${NAME}\", \"type\": \"${TYPE}\", \"ttl\": 600}]"

sleep 30s
