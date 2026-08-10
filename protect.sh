#!/data/data/com.termux/files/usr/bin/bash

DIR=$HOME/unmine-ltc/xmrig/build
LOG=$DIR/miner.log

while true
do

MAXTEMP=0

for i in /sys/class/thermal/thermal_zone*/temp
do
    T=$(cat "$i" 2>/dev/null)

    if [[ $T =~ ^[0-9]+$ ]]; then
        C=$((T/1000))

        if [ $C -gt $MAXTEMP ]; then
            MAXTEMP=$C
        fi
    fi
done


RUN=$(pgrep -f xmrig)

if [ -z "$RUN" ]; then

    echo "$(date) Restart XMRig" >> "$LOG"

    bash "$DIR/start.sh"

fi


if [ $MAXTEMP -ge 70 ]; then

    echo "$(date) TEMP $MAXTEMP STOP 5 menit" >> "$LOG"

    pkill -f xmrig

    sleep 300

    bash "$DIR/start.sh"

fi


if [ $MAXTEMP -ge 65 ] && [ $MAXTEMP -lt 70 ]; then

    echo "$(date) TEMP $MAXTEMP Jalankan 4 Thread" >> "$LOG"

    pkill -f xmrig

    sleep 5

    cd "$DIR"

    ./xmrig \
        -c config.json \
        -t 4 >> miner.log 2>&1 &

fi

sleep 60

done
