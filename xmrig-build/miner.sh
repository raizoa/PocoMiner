#!/data/data/com.termux/files/usr/bin/bash

case $1 in

ltc)
echo "Mining LTC..."
./xmrig -c config_ltc.json --threads=4
;;

btc)
echo "Mining BTC..."
./xmrig -c config_btc.json --threads=4
;;

doge)
echo "Mining DOGE..."
./xmrig -c config_doge.json --threads=4
;;

*)
echo "Usage:"
echo "./miner.sh ltc"
echo "./miner.sh btc"
echo "./miner.sh doge"
;;

esac
