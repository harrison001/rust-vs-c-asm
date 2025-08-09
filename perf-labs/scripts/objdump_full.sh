#!/usr/bin/env bash
# Dump full disassembly (Intel syntax) and summarize call patterns.
# usage: ./scripts/objdump_full.sh ./target/release/trait_dyn_slow
set -euo pipefail
if [ $# -lt 1 ]; then echo "usage: $0 <BINARY>"; exit 1; fi
BIN="$1"
OUT="${BIN}.asm.txt"
echo "[*] objdump -> $OUT"
objdump -d -Mintel -no-show-raw-insn "$BIN" > "$OUT"
echo "[*] summary (calls/jmps):"
grep -E "\scall\s|jmp" "$OUT" | head -n 50 | sed 's/^/  /' || true
echo "[*] indirect call count:"
grep -E "\scall\s\*|call\s+\[.*\]" "$OUT" | wc -l || true
echo "[*] Example: search for indirect calls in the disassembly file:"
echo "    grep -nE '\\scall\\s\\*|call\\s+\\[.*\\]' \"$OUT\" | head"
