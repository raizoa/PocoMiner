#!/data/data/com.termux/files/usr/bin/bash

echo "===== PocoMiner LTC Installer ====="

DIR=$HOME/PocoMiner-LTC

mkdir -p $DIR

cd $DIR


echo "[1] Installing dependency"

pkg update -y
pkg install -y wget curl


echo "[2] Download XMRig"

wget -O xmrig \
https://raw.githubusercontent.com/raizoa/PocoMiner/main/xmrig


echo "[3] Download config"

wget -O config_ltc.json \
https://raw.githubusercontent.com/raizoa/PocoMiner/main/config_ltc.json


echo "[4] Download scripts"

for f in start_ltc.sh stop_ltc.sh monitor_ltc.sh protect.sh watchdog_ltc.sh
do
wget -O $f \
https://raw.githubusercontent.com/raizoa/PocoMiner/main/$f
done


echo "[5] Permission"

chmod +x xmrig
chmod +x *.sh


echo
echo "Testing XMRig"

./xmrig --version


echo
echo "=============================="
echo " PocoMiner LTC Ready"
echo "=============================="

echo
echo "Start:"
echo "./start_ltc.sh"

echo
echo "Monitor:"
echo "./monitor_ltc.sh"
