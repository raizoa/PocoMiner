#!/data/data/com.termux/files/usr/bin/bash

set -e

clear

echo "=============================="
echo "     PocoMiner v2 Installer"
echo "=============================="
echo


BASE=$HOME/PocoMiner-LTC


echo "[1] System Check"

if [ ! -f system_check.sh ]; then
    echo "Downloading system check..."
    curl -sL \
    https://raw.githubusercontent.com/raizoa/PocoMiner/main/system_check.sh \
    -o system_check.sh
fi


chmod +x system_check.sh

./system_check.sh || {
    echo "SYSTEM CHECK FAILED"
    exit 1
}


echo
echo "[2] Install Dependency"


pkg update -y
pkg upgrade -y

pkg install -y \
git \
wget \
curl \
nano \
openssl \
libuv \
jq


echo
echo "[3] Check Tools"


command -v git >/dev/null || {
echo "Git error"
exit 1
}


command -v curl >/dev/null || {
echo "Curl error"
exit 1
}


echo
echo "[4] Download PocoMiner"


cd $HOME


if [ -d "$BASE" ]; then

echo "PocoMiner exists"
echo "Updating..."

cd $BASE
git pull

else

git clone \
https://github.com/raizoa/PocoMiner.git \
$BASE

fi


echo
echo "[5] Permission"


cd $BASE

chmod +x *.sh
chmod +x xmrig


echo
echo "[6] Test XMRig"


./xmrig --version || {

echo "XMRig ERROR"
exit 1

}


echo
echo "[7] Create command"


mkdir -p $HOME/bin


cat > $HOME/bin/poco <<EOF
#!/data/data/com.termux/files/usr/bin/bash
cd $BASE
./poco
EOF


chmod +x $HOME/bin/poco


echo
echo "=============================="
echo " INSTALL COMPLETE"
echo "=============================="

echo
echo "Run:"
echo

echo "poco"
