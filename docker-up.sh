#!/bin/bash

ROOTDIR=$(dirname "$0")
if [ "$ROOTDIR" = "." ]; then
    ROOTDIR=$(pwd)
fi
echo "1. ROOTDIR:$ROOTDIR"

clear && docker-compose up -d --build --force-recreate

ENTRYPOINT=$ROOTDIR/entrypoint.sh

if [ ! -f "$ENTRYPOINT" ]; then
    echo "Entrypoint script not found."
    exit 1
fi

CNAME=nodejs-dev
CID=$(docker ps -q -f name=$CNAME)

if [ -z "$CID" ]; then
    echo "$CNAME container not found."
    exit 1
fi

echo "ENTRYPOINT:$ENTRYPOINT --> $CID:/entrypoint.sh"
docker cp $ENTRYPOINT $CID:/entrypoint.sh

docker exec -it $CID /bin/bash -c "chmod +x /entrypoint.sh && /entrypoint.sh 0"
