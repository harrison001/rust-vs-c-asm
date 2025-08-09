#!/usr/bin/env bash
# Generate flamegraphs for all release binaries in this project.
# Usage: ./scripts/gen_all_flamegraphs.sh
# Output: ./flamegraphs/<bin>.svg
set -euo pipefail

OUTDIR=./flamegraphs
mkdir -p "$OUTDIR"

# Build in release first
echo "[*] cargo build --release"
cargo build --release

# List of binaries (keep in sync with Cargo.toml)
bins=(
  arc_mutex_slow
  arc_mutex_fast
  trait_dyn_slow
  trait_generic_fast
  box_alloc_slow
  vec_contig_fast
  vec_reserve_slow
  vec_reserve_fast
  async_microtasks_slow
  async_batched_fast
  clone_big_slow
  clone_ref_fast
  refcell_slow
  plain_mut_fast
)

# Pick flamegraph tool
FG_TOOL=""
if command -v inferno-flamegraph >/dev/null; then
  FG_TOOL="inferno"
elif command -v stackcollapse-perf.pl >/dev/null && command -v flamegraph.pl >/dev/null; then
  FG_TOOL="brendan"
else
  echo "[!] No flamegraph tool found."
  echo "    Install one of:"
  echo "      cargo install inferno"
  echo "      or clone https://github.com/brendangregg/FlameGraph and add to PATH"
  exit 2
fi

for b in "${bins[@]}"; do
  BIN=./target/release/$b
  if [ ! -x "$BIN" ]; then
    echo "[!] Missing binary: $BIN (skipping)"
    continue
  fi
  SVG="$OUTDIR/${b}.svg"
  echo "============================================================"
  echo "[*] Recording perf for $b ..."
  perf record -F 999 -g -- "$BIN"
  echo "[*] Generating flamegraph -> $SVG"
  if [ "$FG_TOOL" = "inferno" ]; then
    perf script | inferno-flamegraph > "$SVG"
  else
    perf script | stackcollapse-perf.pl | flamegraph.pl > "$SVG"
  fi
  echo "[+] Wrote $SVG"
done

echo "All flamegraphs in $OUTDIR"
