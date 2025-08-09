#!/usr/bin/env bash
# Compare number of indirect calls between two binaries
# usage: ./scripts/objdump_compare_indirect.sh ./slow ./fast
set -euo pipefail
if [ $# -lt 2 ]; then echo "usage: $0 <SLOW_BIN> <FAST_BIN>"; exit 1; fi
slow="$1"; fast="$2"
s=$(objdump -d -Mintel -no-show-raw-insn "$slow" | grep -E "\scall\s\*|call\s+\[.*\]" | wc -l || true)
f=$(objdump -d -Mintel -no-show-raw-insn "$fast" | grep -E "\scall\s\*|call\s+\[.*\]" | wc -l || true)
echo "Indirect calls:"
printf "  SLOW (%s): %s\n" "$slow" "$s"
printf "  FAST (%s): %s\n" "$fast" "$f"
