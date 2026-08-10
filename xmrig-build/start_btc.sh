#!/data/data/com.termux/files/usr/bin/bash

cd "$(dirname "$0")"

if pgrep -f "./xmrig" >/dev/null; then
    echo "Mining sudah berjalan"
    exit 0
fi

echo "Starting XMRig BTC..."

nohup ./xmrig -c config_btc.json -l miner_btc.log >/dev/null 2>&1 &

echo "Mining BTC started"
