#!/data/data/com.termux/files/usr/bin/bash

echo "Stopping BTC Miner..."

pkill -f xmrig

sleep 2

if pgrep -f xmrig > /dev/null
then
    echo "Miner masih berjalan, force stop..."
    pkill -9 -f xmrig
else
    echo "BTC Mining stopped"
fi
