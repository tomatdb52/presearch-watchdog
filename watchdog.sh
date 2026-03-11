#!/bin/bash
CONTAINER_NAME="presearch-node"
KUMA_URL="http://100.122.163.39:3001/api/push/QgsOj047vh"

STATUS=$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME 2>/dev/null)
if [ "$STATUS" = "true" ]; then
    MSG="OK"
    STATE="up"
else
    docker start $CONTAINER_NAME > /dev/null 2>&1
    MSG="RESTARTED"
    STATE="down"
fi
TEMP=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')
curl -s "${KUMA_URL}?status=${STATE}&msg=${MSG}&ping=${TEMP}"
