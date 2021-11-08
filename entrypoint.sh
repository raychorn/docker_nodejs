#!/bin/bash

SLEEPING=$1 # 0 = no, 1 = yes

ROOTDIR=$(dirname "$0")
if [ "$ROOTDIR" = "." ]; then
    ROOTDIR=$(pwd)
fi
echo "1. ROOTDIR:$ROOTDIR"

sleeping () {
    echo "2. sleeping $SLEEPING"
    if [ "$SLEEPING." == "1." ]; then
        while true; do
            echo "Sleeping... forever."
            sleep 999999999
        done
    else
        echo "Cannot sleep must exit."
        exit 1
    fi
}

apt-get update -y && apt-get upgrade -y

export DEBIAN_FRONTEND=noninteractive

TZ=$(echo $TZ)

if [ "$TZ" = "" ]; then
    TZ=America/Denver
fi

export TZ=$TZ

apt-get install -y tzdata

apt-get update -y
apt-get install net-tools -y
apt-get install iputils-ping -y
apt-get install nano -y

apt-get install -y apt-utils && apt-get install -y curl

echo "Done prepping the container."

while true; do
    sleep 10
done
