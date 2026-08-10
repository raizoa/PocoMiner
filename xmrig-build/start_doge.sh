#!/data/data/com.termux/files/usr/bin/bash

cd "$(dirname "$0")"

if pgrep -f "./xmrig" >/dev/null; then
    echo "Mining sudah berjalan"
    exit 0
fi

echo "Starting XMRig DOGE..."

nohup ./xmrig -c config_doge.json -l miner_doge.log >/dev/null 2>&1 &

echo "Mining DOGE started"
