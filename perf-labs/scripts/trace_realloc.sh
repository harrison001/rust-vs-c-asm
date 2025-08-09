#!/usr/bin/env bash
# usage: sudo ./scripts/trace_realloc.sh ./target/release/vec_reserve_slow
set -euo pipefail
if [ $# -lt 1 ]; then echo "usage: sudo $0 <PROGRAM> [args...]"; exit 1; fi
LIBC="${LIBC_PATH:-$(./scripts/find_libc.sh)}"
echo "Using libc at: $LIBC"
bpftrace -e "uprobe:$LIBC:realloc { @realloc = count(); } END { print(@realloc); }" -c "$@"
