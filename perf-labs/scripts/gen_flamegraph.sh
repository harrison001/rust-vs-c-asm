#!/usr/bin/env bash
# Generate flamegraph for a binary if tools available.
# usage: ./scripts/gen_flamegraph.sh ./target/release/arc_mutex_slow out.svg
set -euo pipefail
if [ $# -lt 2 ]; then echo "usage: $0 <BINARY> <OUT_SVG>"; exit 1; fi
BIN="$1"; OUT="$2"
echo "[*] Recording perf data..."
perf record -F 999 -g -- "$BIN"
echo "[*] Generating flamegraph..."
if command -v inferno-flamegraph >/dev/null; then
  perf script | inferno-flamegraph > "$OUT"
  echo "[+] Wrote $OUT via inferno-flamegraph"
elif command -v stackcollapse-perf.pl >/dev/null && command -v flamegraph.pl >/dev/null; then
  perf script | stackcollapse-perf.pl | flamegraph.pl > "$OUT"
  echo "[+] Wrote $OUT via FlameGraph tools"
else
  echo "[!] No flamegraph tool found. You can install either:"
  echo "    cargo install inferno"
  echo "  or clone https://github.com/brendangregg/FlameGraph and add to PATH."
  exit 2
fi
