#!/usr/bin/env bash
# usage: ./scripts/gdb_run.sh ./target/release/trait_dyn_slow
set -euo pipefail
if [ $# -lt 1 ]; then echo "usage: $0 <BINARY> [args...]"; exit 1; fi
gdb -q -x "$(dirname "$0")/gdb_layout_asm.gdb" --args "$@"
