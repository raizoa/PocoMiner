#!/data/data/com.termux/files/usr/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
XMRIG="$BASE_DIR/xmrig-build/xmrig"
LOG="$BASE_DIR/miner_xmr.log"

while true
do
    clear

    echo "===== POCO X5 XMRIG XMR MONITOR ====="
    echo

    MINER=$(pgrep -f "$XMRIG")

    if [ -z "$MINER" ]; then
        echo "Miner : STOPPED"
    else
        echo "Miner : RUNNING"
    fi

    echo
    echo "Threads:"

    THREAD=$(grep "READY threads" "$LOG" 2>/dev/null | tail -1)

    if [ -z "$THREAD" ]; then
        echo "Waiting..."
    else
        echo "$THREAD"
    fi

    echo
    echo "Hashrate:"

    HASH=$(grep "miner    speed" "$LOG" 2>/dev/null | tail -1)

    if [ -z "$HASH" ]; then
        echo "Waiting..."
    else
        echo "$HASH" | sed 's/.*speed //'
    fi

    echo

    ACCEPT=$(grep -ci "accepted" "$LOG" 2>/dev/null)
    REJECT=$(grep -ci "rejected" "$LOG" 2>/dev/null)

    echo "Accepted : $ACCEPT"
    echo "Rejected : $REJECT"

    echo

    MAXTEMP=0

    for i in /sys/class/thermal/thermal_zone*/temp
    do
        T=$(cat "$i" 2>/dev/null)

        if [[ $T =~ ^[0-9]+$ ]]; then
            C=$((T/1000))

            if [ "$C" -gt "$MAXTEMP" ]; then
                MAXTEMP=$C
            fi
        fi
    done

    echo "CPU Temp : $MAXTEMP C"

    echo
    echo "CPU Frequency"

    for i in 0 1 2 3 4 5 6 7
    do
        F=$(cat /sys/devices/system/cpu/cpu$i/cpufreq/scaling_cur_freq 2>/dev/null)

        if [ -n "$F" ]; then
            echo "CPU$i : $((F/1000)) MHz"
        fi
    done

    echo

    if [ "$MAXTEMP" -lt 65 ]; then
        echo "Status : SAFE"
    elif [ "$MAXTEMP" -lt 70 ]; then
        echo "Status : WARNING"
    else
        echo "Status : HOT"
    fi

    echo
    echo "Refresh : 5 seconds"

    sleep 5
done
