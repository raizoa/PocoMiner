#!/data/data/com.termux/files/usr/bin/bash

echo "================================"
echo "      POCO MINER LTC INSTALLER"
echo "================================"

echo "[1] Update package"

pkg update -y

echo "[2] Install dependency"

pkg install -y git wget curl nano

echo "[3] Download PocoMiner"

cd ~

if [ -d "PocoMiner-LTC" ]; then
    echo "Folder PocoMiner-LTC sudah ada"
    echo "Update repository..."
    
    cd ~/PocoMiner-LTC
    git pull

else
    git clone https://github.com/raizoa/PocoMiner.git PocoMiner-LTC
fi


echo "[4] Permission"

cd ~/PocoMiner-LTC

chmod +x xmrig
chmod +x *.sh


echo "[5] Test XMRig"

./xmrig --version


echo
echo "================================"
echo " PocoMiner LTC READY"
echo "================================"

echo
echo "Folder:"
echo "~/PocoMiner-LTC"

echo
echo "Start:"
echo "cd ~/PocoMiner-LTC"
echo "./start_ltc.sh"

echo
echo "Monitor:"
echo "./monitor_ltc.sh"
