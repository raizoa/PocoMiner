#!/bin/bash

BASE_DIR="/app"
XMRIG="$BASE_DIR/xmrig"
CONFIG="$BASE_DIR/config_railway_ltc.json"

echo "========================================"
echo "       PocoMiner - Railway LTC"
echo "========================================"
echo "Architecture: $(uname -m)"
echo "XMRig       : $XMRIG"
echo "Config      : $CONFIG"
echo "CPU Threads : 4"
echo "========================================"

if [ ! -x "$XMRIG" ]; then
    echo "ERROR: Linux XMRig tidak ditemukan atau tidak executable"
    ls -lah "$XMRIG" 2>&1
    exit 1
fi

echo "Starting XMRig LTC..."

exec "$XMRIG" \
    -c "$CONFIG"
