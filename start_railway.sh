#!/bin/bash

echo "========================================"
echo "       PocoMiner - Railway DEBUG"
echo "========================================"

echo "Architecture:"
uname -m

echo "Files /app:"
ls -lah /app

echo "Checking XMRig:"
ls -lah /app/xmrig 2>&1

echo "File type:"
file /app/xmrig 2>&1

echo "========================================"
echo "Searching XMRig:"
find /app -type f -name xmrig -ls 2>/dev/null

echo "========================================"
