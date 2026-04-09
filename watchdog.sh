#!/bin/bash
CONTAINER_NAME="presearch-node"
KUMA_URL="https://YOUR_KUMA_URL_HERE/api/push/YOUR_KEY"
STATUS=$(docker inspect -f '{{.State.Status}}' $CONTAINER_NAME 2>/dev/null)
LOGS=$(docker logs --since 10m $CONTAINER_NAME 2>&1)
if [ "$STATUS" != "running" ]; then
    MSG="DOWN - Container status: $STATUS"
    STATE="down"
    docker restart $CONTAINER_NAME > /dev/null 2>&1
elif echo "$LOGS" | grep -q "Node version is too old"; then
    MSG="DOWN - Version too old"
    STATE="down"
    docker restart $CONTAINER_NAME > /dev/null 2>&1
elif ! echo "$LOGS" | grep -E -q "Waiting for search requests|Registration success"; then
    MSG="DOWN - No connection"
    STATE="down"
    docker restart $CONTAINER_NAME > /dev/null 2>&1
else
    MSG="OK"
    STATE="up"
fi
TEMP=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')
curl -s "${KUMA_URL}?status=${STATE}&msg=${MSG// /%20}&ping=${TEMP}"
