#!/usr/bin/env bash
# Try cargo-asm to dump Rust function assembly (requires nightly + cargo-asm)
# usage: ./scripts/cargo_asm_example.sh 'rust_perf_demos::main'
set -euo pipefail
if ! command -v cargo >/dev/null; then echo "cargo not found"; exit 1; fi
if ! cargo asm -V >/dev/null 2>&1; then
  echo "cargo-asm not installed. Install with: cargo install cargo-asm (nightly toolchain)"
  exit 1
fi
if [ $# -lt 1 ]; then echo "usage: $0 <SYMBOL> (e.g., rust_perf_demos::main)"; exit 1; fi
SYM="$1"
echo "[*] cargo asm $SYM"
cargo asm "$SYM" --rust --simplify
