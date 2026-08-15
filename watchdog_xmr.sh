#!/data/data/com.termux/files/usr/bin/bash

cd "$(dirname "$0")"

while true
do

if ! pgrep -f "xmrig.*config_xmr.json" >/dev/null
then
    echo "$(date) Miner mati, restart..." >> watchdog.log

    ./start_xmr.sh
fi

sleep 60

done
