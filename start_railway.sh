#!/bin/bash

BASE_DIR="/app"
XMRIG="$BASE_DIR/xmrig-build/xmrig"
CONFIG="$BASE_DIR/config_ltc.json"
LOG="$BASE_DIR/miner_ltc.log"

echo "========================================"
echo "       PocoMiner - Railway LTC"
echo "========================================"
echo "Architecture: $(uname -m)"
echo "XMRig       : $XMRIG"
echo "Config      : $CONFIG"
echo "========================================"

if [ ! -x "$XMRIG" ]; then
    echo "ERROR: Linux XMRig tidak berhasil dibuat"
    exit 1
fi

exec "$XMRIG" \
    -c "$CONFIG" \
    -l "$LOG"
