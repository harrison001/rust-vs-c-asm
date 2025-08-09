#!/usr/bin/env bash
# usage: sudo ./scripts/trace_futex.sh ./target/release/arc_mutex_slow
set -euo pipefail
if [ $# -lt 1 ]; then echo "usage: sudo $0 <PROGRAM> [args...]"; exit 1; fi
bpftrace -e 'tracepoint:syscalls:sys_enter_futex { @futex = count(); } END { print(@futex); }' -c "$@"
