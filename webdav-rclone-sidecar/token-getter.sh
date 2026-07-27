#!/bin/bash
set -e

TOKEN_URL="$(echo -n "$SHARE_MANAGER_URL" | sed 's/\/\+$//')/token/$JUPYTERHUB_USER"
curl -s -q "$TOKEN_URL" -H "Authorization: bearer $SHARE_MANAGER_TOKEN" |
	jq -r '.access_token'
