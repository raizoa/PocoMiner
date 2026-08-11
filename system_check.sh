#!/data/data/com.termux/files/usr/bin/bash

echo "=============================="
echo " PocoMiner System Check"
echo "=============================="


# Termux check
if [ -z "$PREFIX" ]; then
echo "ERROR: Not Termux"
exit 1
fi

echo "[OK] Termux detected"


# CPU
ARCH=$(uname -m)

if [ "$ARCH" != "aarch64" ]; then
echo "WARNING: CPU $ARCH"
else
echo "[OK] ARM64 CPU"
fi


# Core
CORE=$(nproc)

echo "[INFO] CPU Core : $CORE"


# RAM
RAM=$(free -m | awk '/Mem:/ {print $2}')

echo "[INFO] RAM : ${RAM}MB"


# Storage
SPACE=$(df $HOME | awk 'NR==2 {print $4}')

# convert KB to MB
SPACE_MB=$((SPACE / 1024))

echo "[INFO] Free Storage : ${SPACE_MB}MB"


if [ "$SPACE_MB" -lt 500 ]; then
echo "ERROR: Storage kurang"
exit 1
fi

echo
echo "SYSTEM CHECK PASS"
