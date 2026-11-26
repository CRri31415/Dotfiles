#!/usr/bin/env bash

playerctl --follow metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "class": "{{status}}"}' 2>/dev/null
