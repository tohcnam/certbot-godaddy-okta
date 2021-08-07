#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
source $DIR/certbot-settings.sh

certbot certonly \
        --force-renewal \
        --non-interactive \
        --agree-tos \
        --manual-public-ip-logging-ok \
        -m $EMAIL \
        --preferred-challenges dns \
        --manual \
        --manual-auth-hook $DIR/certbot-auth-hook.sh \
        --manual-cleanup-hook $DIR/certbot-cleanup-hook.sh \
        --deploy-hook $DIR/certbot-deploy-hook.sh \
        -d "${SUBDOMAIN}.${DOMAIN}"
