#!/usr/bin/env bash
# usage: sudo ./scripts/trace_malloc.sh ./target/release/box_alloc_slow
set -euo pipefail
if [ $# -lt 1 ]; then echo "usage: sudo $0 <PROGRAM> [args...]"; exit 1; fi
LIBC="${LIBC_PATH:-$(./scripts/find_libc.sh)}"
echo "Using libc at: $LIBC"
bpftrace -e "uprobe:$LIBC:malloc { @malloc = count(); } END { print(@malloc); }" -c "$@"
