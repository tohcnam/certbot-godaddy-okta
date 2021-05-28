#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/certbot-settings.sh

echo "RENEWED_LINEAGE: ${RENEWED_LINEAGE}"

domains=`curl -s -X GET -H "Accept: application/json" -H "Content-Type: application/json" -H "Authorization: SSWS ${OKTA_API_KEY}" "${OKTA_ORG_URL}/api/v1/domains"`
domainid=`echo $domains | cut -d ',' -f 1 | cut -d '"' -f 6`

API_URL="${OKTA_ORG_URL}/api/v1/domains/${domainid}/certificate"
CERT=$(cat "${RENEWED_LINEAGE}/cert.pem" | sed '$!s/$/\\n/' | tr -d '\n')
KEY=$(cat "${RENEWED_LINEAGE}/privkey.pem" | sed '$!s/$/\\n/' | tr -d '\n')
CHAIN=$(cat "${RENEWED_LINEAGE}/chain.pem" | sed '$!s/$/\\n/' | tr -d '\n')

echo "Updating Okta Certs"

curl    -s \
        -X PUT \
        $API_URL \
        -H "accept: application/json" \
        -H "Content-Type: application/json" \
        -H "Authorization: SSWS ${OKTA_API_KEY}" \
        -d "{\"type\": \"PEM\", \"privateKey\": \"${KEY}\", \"certificate\": \"${CERT}\", \"certificateChain\": \"${CHAIN}\"}"