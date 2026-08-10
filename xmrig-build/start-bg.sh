#!/data/data/com.termux/files/usr/bin/bash

cd ~/unmine-ltc/xmrig/build

pkill -f protect.sh 2>/dev/null

nohup ./protect.sh >/dev/null 2>&1 &

echo "XMRig Auto Protect berjalan"
