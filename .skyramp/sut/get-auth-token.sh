#!/usr/bin/env bash
set -e

CODER_URL="${CODER_URL:-http://localhost:7080}"
ADMIN_EMAIL="testadmin@coder.com"
ADMIN_USERNAME="testadmin"
ADMIN_PASSWORD="SkyRampT3stP@ss1"

# Create first admin user. Ignore errors if it already exists.
curl -s -X POST "${CODER_URL}/api/v2/users/first" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"${ADMIN_EMAIL}\",\"username\":\"${ADMIN_USERNAME}\",\"name\":\"Test Admin\",\"password\":\"${ADMIN_PASSWORD}\",\"trial\":false}" \
  > /dev/null 2>&1 || true

# Authenticate and print the session token.
LOGIN_RESPONSE=$(curl -sf -X POST "${CODER_URL}/api/v2/users/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"${ADMIN_EMAIL}\",\"password\":\"${ADMIN_PASSWORD}\"}")

python3 -c "import sys, json; print(json.loads(sys.stdin.read())['session_token'])" <<< "${LOGIN_RESPONSE}"
