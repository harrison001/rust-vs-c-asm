# Rust Performance Demos (slow vs fast)

Each pair shows a classic Rust performance pitfall and an optimized version. 
Test on Linux with `perf`, `bpftrace`, `valgrind/heaptrack`, and optionally `tokio-console`.

## Quick start
```bash
cd rust-perf-demos
cargo build --release
# Example:
taskset -c 0-3 perf stat -d -r 5 ./target/release/arc_mutex_slow
taskset -c 0-3 perf stat -d -r 5 ./target/release/arc_mutex_fast
```

## Scripted runs
See `scripts/` for ready-made commands:
- `perf_compare.sh` – run perf stat on slow/fast pairs
- `trace_futex.sh` – count futex calls (locks)
- `trace_malloc.sh` – count malloc calls via bpftrace uprobes
- `trace_realloc.sh` – count realloc calls
- `trace_sched_switch.sh` – show scheduler switches for a target
- `find_libc.sh` – attempt to locate libc.so for uprobes

> Most bpftrace scripts need root: `sudo ./scripts/trace_futex.sh <binary>`.

## Binaries
- arc_mutex_slow / arc_mutex_fast
- trait_dyn_slow / trait_generic_fast
- box_alloc_slow / vec_contig_fast
- vec_reserve_slow / vec_reserve_fast
- async_microtasks_slow / async_batched_fast
- clone_big_slow / clone_ref_fast
- refcell_slow / plain_mut_fast

## Notes
- Build with `--release` for meaningful numbers.
- Pin to a fixed set of CPUs (e.g., `taskset -c 0-3`) to reduce variance.
- For async demos, install `tokio-console` if you want runtime insights.
```
cargo install tokio-console
RUST_LOG=tokio=trace RUSTFLAGS="--cfg tokio_unstable" TOKIO_CONSOLE_BIND=127.0.0.1:6669 ./target/release/async_microtasks_slow
```

## Advanced analysis scripts

- `scripts/objdump_full.sh <bin>` – dump full Intel-syntax assembly and summarize calls (counts indirect calls).
- `scripts/objdump_compare_indirect.sh <slow> <fast>` – compare indirect call counts.
- `scripts/cargo_asm_example.sh <symbol>` – try `cargo asm` (nightly) for function-level assembly.
- `scripts/gen_flamegraph.sh <bin> out.svg` – record perf and emit a flamegraph (needs `inferno` or FlameGraph).
- `scripts/gdb_run.sh <bin>` – open gdb with preloaded asm-friendly layout script.


### Batch flamegraphs

Generate flamegraphs for **all** demos:
```bash
./scripts/gen_all_flamegraphs.sh
# SVG outputs are in ./flamegraphs/
```
If you lack a tool, install one:
```bash
cargo install inferno
# or use Brendan Gregg's FlameGraph repo (stackcollapse-perf.pl + flamegraph.pl)
```


### Side-by-side pair compare

Generate **slow vs fast** flamegraphs and an HTML viewer:
```bash
./scripts/gen_pair_flamegraphs.sh ./target/release/trait_dyn_slow ./target/release/trait_generic_fast
# Open the emitted HTML under ./flamegraphs/
```
