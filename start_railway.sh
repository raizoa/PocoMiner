#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
XMRIG="$BASE_DIR/xmrig-build/xmrig"
CONFIG="$BASE_DIR/config_ltc.json"
LOG="$BASE_DIR/miner_ltc.log"

echo "Starting LTC Miner..."

if [ ! -x "$XMRIG" ]; then
    echo "ERROR: XMRig tidak ditemukan atau tidak executable"
    exit 1
fi

exec "$XMRIG" -c "$CONFIG" -l "$LOG"
