#!/bin/bash

WIFI_LINE=$(nmcli -t -f IN-USE,SSID,SIGNAL dev wifi list --rescan no 2>/dev/null | grep -E '^\*|^ \*')

if [ -n "$WIFI_LINE" ]; then
    SSID=$(echo "$WIFI_LINE" | cut -d: -f2)
    SIGNAL=$(echo "$WIFI_LINE" | cut -d: -f3)

    if [ -n "$SSID" ]; then
        echo "${SSID}:${SIGNAL}"
        exit 0
    fi
fi

echo "Disconnected:0"
