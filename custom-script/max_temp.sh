#!/usr/bin/env bash

max_temp=$(sensors | grep -oP ':\s*\+\K[0-9]+(\.[0-9]+)?(?=°C)' | sort -nr | head -n1)

if [ -z "$max_temp" ]; then
  max_temp="N/A"
fi

echo "{\"text\": \"${max_temp}°C\"}"
