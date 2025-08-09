#!/usr/bin/env bash
# usage: sudo ./scripts/trace_sched_switch.sh ./target/release/async_microtasks_slow
set -euo pipefail
if [ $# -lt 1 ]; then echo "usage: sudo $0 <PROGRAM> [args...]"; exit 1; fi
bpftrace -e 'tracepoint:sched:sched_switch { @sw[comm] = count(); } END { print(@sw); }' -c "$@"
