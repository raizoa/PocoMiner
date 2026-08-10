#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
XMRIG="$BASE_DIR/xmrig-build/xmrig"
CONFIG="$BASE_DIR/config_ltc.json"
LOG="$BASE_DIR/miner_ltc.log"

if pgrep -f "$XMRIG" >/dev/null 2>&1; then
    echo "LTC Mining sudah berjalan"
    exit 0
fi

if [ ! -x "$XMRIG" ]; then
    echo "ERROR: XMRig tidak ditemukan:"
    echo "$XMRIG"
    exit 1
fi

echo "Starting XMRig LTC..."

nohup "$XMRIG" \
    -c "$CONFIG" \
    -l "$LOG" \
    >/dev/null 2>&1 &

sleep 2

if pgrep -f "$XMRIG" >/dev/null 2>&1; then
    echo "LTC Mining started"
else
    echo "Gagal menjalankan LTC miner"
    echo "Cek: $LOG"
fi
