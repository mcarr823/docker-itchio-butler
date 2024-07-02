#!/bin/bash
set -e

# Config exec user
PUID=${PUID:-0}
PGID=${PGID:-0}

groupmod -o -g "$PGID" butler
usermod -o -u "$PUID" butler

su butler -c "./butler $*"
