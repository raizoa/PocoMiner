#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
XMRIG="$BASE_DIR/xmrig-build/xmrig"

echo "Stopping LTC Miner..."

PIDS=$(pgrep -f "$XMRIG")

if [ -z "$PIDS" ]; then
    echo "LTC Miner tidak sedang berjalan"
    exit 0
fi

kill $PIDS
sleep 2

PIDS=$(pgrep -f "$XMRIG")

if [ -n "$PIDS" ]; then
    echo "Miner masih berjalan, force stop..."
    kill -9 $PIDS
else
    echo "LTC Mining stopped"
fi
