#!/usr/bin/env bash
set -euo pipefail
BIN_DIR=./target/release
CPUSET=${CPUSET:-0-3}
REPEAT=${REPEAT:-5}

pairs=(
  "arc_mutex_slow arc_mutex_fast"
  "trait_dyn_slow trait_generic_fast"
  "box_alloc_slow vec_contig_fast"
  "vec_reserve_slow vec_reserve_fast"
  "async_microtasks_slow async_batched_fast"
  "clone_big_slow clone_ref_fast"
  "refcell_slow plain_mut_fast"
)

echo "Building release..."; cargo build --release

for pair in "${pairs[@]}"; do
  slow=$(echo $pair | awk '{print $1}')
  fast=$(echo $pair | awk '{print $2}')
  echo "================================================================"
  echo "Pair: $slow  VS  $fast"
  echo "----------------------------------------------------------------"
  echo "[SLOW] $slow"
  taskset -c "$CPUSET" perf stat -d -r "$REPEAT" "$BIN_DIR/$slow" 2>&1 | sed 's/^/  /'
  echo "----------------------------------------------------------------"
  echo "[FAST] $fast"
  taskset -c "$CPUSET" perf stat -d -r "$REPEAT" "$BIN_DIR/$fast" 2>&1 | sed 's/^/  /'
done
