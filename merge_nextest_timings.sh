#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="target/nextest/timings"

if [[ ! -d "$OUT_DIR" ]]; then
  echo "Directory '$OUT_DIR' not found." >&2
  exit 1
fi

cd "$OUT_DIR"

shopt -s nullglob
CSV_FILES=(*-times.csv)
shopt -u nullglob

if [ ${#CSV_FILES[@]} -eq 0 ]; then
  echo "No *-times.csv files found in $OUT_DIR" >&2
  exit 1
fi

# First file provides the header; others contribute rows (skip their header)
{
  head -n1 "${CSV_FILES[0]}"
  for f in "${CSV_FILES[@]}"; do
    tail -n +2 "$f"
  done
} | sort -t',' -k1,1nr > all-tests-by-time.csv

echo "Merged CSV written to $OUT_DIR/all-tests-by-time.csv"

