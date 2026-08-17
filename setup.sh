#!/data/data/com.termux/files/usr/bin/bash

export DEBIAN_FRONTEND=noninteractive
export TERMUX_PKG_NO_PROMPT=1

set -e

clear

echo "=============================="
echo "     PocoMiner v2 Installer"
echo "=============================="
echo


BASE=$HOME/PocoMiner


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

echo "[2] Repair package"

apt --fix-broken install -y || true

yes | pkg update -y
yes | pkg upgrade -y

echo "[3] Install dependency"

yes | pkg install -y \
git \
wget \
curl \
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


if [ -d "$BASE/.git" ]; then

    echo "PocoMiner git repository exists"
    cd $BASE
    git pull

elif [ -d "$BASE" ]; then

    echo "Folder PocoMiner ada tapi bukan git repo"
    echo "Menghapus folder lama..."

    rm -rf $BASE

    git clone \
    https://github.com/raizoa/PocoMiner.git \
    $BASE

else

    echo "Clone PocoMiner"

    git clone \
    https://github.com/raizoa/PocoMiner.git \
    $BASE

fi

cd "$BASE"

# ==============================
# Generate Unique Worker
# ==============================

echo "[Worker] Generate unique worker"

cd "$BASE" || exit 1

WORKER_FILE="$BASE/worker.txt"

if [ -f "$WORKER_FILE" ]; then

    WORKER=$(cat "$WORKER_FILE")

    echo "[OK] Existing Worker: $WORKER"

else

    # Get device model
    MODEL=$(getprop ro.product.model 2>/dev/null)

    if [ -z "$MODEL" ]; then
        MODEL="ANDROID"
    fi

    MODEL=$(echo "$MODEL" | tr ' ' '-' | tr -cd '[:alnum:]-')

    # Try to get serial number
    DEVICE_ID=$(getprop ro.serialno 2>/dev/null)

    # Clean serial
    DEVICE_ID=$(echo "$DEVICE_ID" | tr -cd '[:alnum:]')

    # If serial unavailable or invalid, generate random ID
    if [ -z "$DEVICE_ID" ] || [ "$DEVICE_ID" = "unknown" ]; then

        DEVICE_ID=$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n' | cut -c1-6)

    else

        DEVICE_ID=$(echo "$DEVICE_ID" | tail -c 7)

    fi

    WORKER="${MODEL}-${DEVICE_ID}"

    echo "$WORKER" > "$WORKER_FILE"

    echo "[OK] New Worker: $WORKER"

fi

# Update worker name in config
sed -i -E "s/(\"user\": \"LTC:[^\"]+\.)[^\" ]+/\1$WORKER/" \
"$BASE/config_ltc.json"

echo "[OK] Worker configured"

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
cd $HOME/PocoMiner
./poco
EOF

chmod +x $HOME/bin/poco

touch ~/.bashrc

if ! grep -q "$HOME/bin" ~/.bashrc; then
    echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
fi

source ~/.bashrc

echo
echo "=============================="
echo " INSTALL COMPLETE"
echo "=============================="

echo
echo "Run:"
echo

echo "poco"
