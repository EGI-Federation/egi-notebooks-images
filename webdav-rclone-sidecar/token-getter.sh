#!/bin/bash
set -e

curl -s -q "$SHARE_MANAGER_URL/token/$JUPYTERHUB_USER" -H "Authorization: bearer $SHARE_MANAGER_TOKEN" | jq -r '.access_token'
