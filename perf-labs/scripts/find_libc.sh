#!/usr/bin/env bash
set -euo pipefail
# Try to locate libc shared object for current system
for p in /lib/x86_64-linux-gnu/libc.so.6 /usr/lib/x86_64-linux-gnu/libc.so.6 /lib64/libc.so.6; do
  if [ -e "$p" ]; then echo "$p"; exit 0; fi
done
# Fallback using ldd on /bin/ls
ldd /bin/ls | awk '/libc\.so/ {print $3; exit}'
