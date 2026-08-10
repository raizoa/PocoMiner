#!/data/data/com.termux/files/usr/bin/bash

cd ~/unmine-ltc/xmrig/build

pkill -9 xmrig 2>/dev/null

sleep 2

nohup ./xmrig -c config.json --threads=1 --log-file=miner.log >/dev/null 2>&1 &

echo "Mining started (1 thread)"
