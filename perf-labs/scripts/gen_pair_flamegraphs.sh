#!/usr/bin/env bash
# Generate side-by-side flamegraphs for a SLOW/FAST binary pair and an HTML viewer.
# Usage:
#   ./scripts/gen_pair_flamegraphs.sh ./target/release/trait_dyn_slow ./target/release/trait_generic_fast
# Output:
#   ./flamegraphs/<slow>.svg, ./flamegraphs/<fast>.svg, ./flamegraphs/compare_<pair>.html
set -euo pipefail
if [ $# -lt 2 ]; then
  echo "usage: $0 <SLOW_BIN> <FAST_BIN>"
  echo "example: $0 ./target/release/trait_dyn_slow ./target/release/trait_generic_fast"
  exit 1
fi

SLOW="$1"
FAST="$2"
OUTDIR=./flamegraphs
mkdir -p "$OUTDIR"

# Resolve nice names
sbase=$(basename "$SLOW")
fbase=$(basename "$FAST")
SLOW_SVG="$OUTDIR/${sbase}.svg"
FAST_SVG="$OUTDIR/${fbase}.svg"
HTML="$OUTDIR/compare_${sbase}_VS_${fbase}.html"

# Pick flamegraph generator
FG_TOOL=""
if command -v inferno-flamegraph >/dev/null; then
  FG_TOOL="inferno"
elif command -v stackcollapse-perf.pl >/dev/null && command -v flamegraph.pl >/dev/null; then
  FG_TOOL="brendan"
else
  echo "[!] No flamegraph tool found."
  echo "    Install inferno (cargo install inferno) or add FlameGraph scripts to PATH."
  exit 2
fi

echo "=== SLOW: $SLOW ==="
perf record -F 999 -g -- "$SLOW"
if [ "$FG_TOOL" = "inferno" ]; then
  perf script | inferno-flamegraph > "$SLOW_SVG"
else
  perf script | stackcollapse-perf.pl | flamegraph.pl > "$SLOW_SVG"
fi
echo "[+] wrote $SLOW_SVG"

echo "=== FAST: $FAST ==="
perf record -F 999 -g -- "$FAST"
if [ "$FG_TOOL" = "inferno" ]; then
  perf script | inferno-flamegraph > "$FAST_SVG"
else
  perf script | stackcollapse-perf.pl | flamegraph.pl > "$FAST_SVG"
fi
echo "[+] wrote $FAST_SVG"

# Simple HTML side-by-side viewer
cat > "$HTML" <<EOF
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<title>Flamegraph compare: $sbase vs $fbase</title>
<style>
body { margin:0; font-family: system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif; }
.header { padding:10px 16px; background:#111; color:#eee; position:sticky; top:0; z-index:10; }
.grid { display:grid; grid-template-columns: 1fr 1fr; gap:0; height: calc(100vh - 52px); }
.col { overflow:auto; border-left:1px solid #ddd; }
.col:first-child { border-left:none; }
.toolbar { font-size:14px; opacity:0.8; }
.object { width:100%; height:100%; border:0; }
</style>
</head>
<body>
<div class="header">
  <div class="toolbar">Comparing <b>$sbase</b> (left) vs <b>$fbase</b> (right)</div>
</div>
<div class="grid">
  <div class="col"><object class="object" type="image/svg+xml" data="${sbase}.svg"></object></div>
  <div class="col"><object class="object" type="image/svg+xml" data="${fbase}.svg"></object></div>
</div>
</body>
</html>
EOF

echo "[+] wrote $HTML"
echo "Open in browser: $HTML"
