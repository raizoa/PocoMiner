#!/data/data/com.termux/files/usr/bin/bash

cd "$(dirname "$0")"

while true
do

if ! pgrep -f "xmrig.*config_ltc.json" >/dev/null
then
    echo "$(date) Miner mati, restart..." >> watchdog.log

    ./start_ltc.sh
fi

sleep 60

done
