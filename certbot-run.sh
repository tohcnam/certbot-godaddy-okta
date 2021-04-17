#!/bin/bash

source ./certbot-settings.sh

certbot certonly \
        --non-interactive \
        --agree-tos \
        --manual-public-ip-logging-ok \
        -m $EMAIL \
        --preferred-challenges dns \
        --manual \
        --manual-auth-hook ./certbot-auth-hook.sh \
        --manual-cleanup-hook ./certbot-cleanup-hook.sh \
        --deploy-hook ./certbot-deploy-hook.sh \
        -d "${SUBDOMAIN}.${DOMAIN}"
