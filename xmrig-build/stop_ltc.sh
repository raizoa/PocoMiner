#!/data/data/com.termux/files/usr/bin/bash

echo "Stopping LTC Miner..."

pkill -f xmrig

sleep 2

if pgrep -f xmrig > /dev/null
then
    echo "Miner masih berjalan, force stop..."
    pkill -9 -f xmrig
else
    echo "LTC Mining stopped"
fi
