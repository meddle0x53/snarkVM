#!/usr/bin/env bash
set -euo pipefail

MATRIX_FILE="test-matrix.txt"
OUT_DIR="target/nextest/timings"
JUNIT_SRC="target/nextest/default/junit.xml"
PY_SCRIPT="nextest_junit_to_csv.py"

mkdir -p "$OUT_DIR"

if [[ ! -f "$MATRIX_FILE" ]]; then
  echo "Matrix file '$MATRIX_FILE' not found." >&2
  exit 1
fi

while read -r label package rest; do
  # skip empty lines and comments
  [[ -z "${label:-}" ]] && continue
  [[ "$label" == \#* ]] && continue

  flags="${rest:-}"

  echo
  echo "=== Running job '$label' (package=$package, flags='$flags') ==="

  # 1) Run nextest
  cargo nextest run \
    -p "$package" \
    --release \
    --profile default \
    -j 1 \
    --status-level fail \
    --hide-progress-bar \
    --no-tests=pass \
    --no-fail-fast \
    ${flags:+$flags} || true

  # 2) Copy JUnit so it doesn't get overwritten by the next job
  junit_copy="$OUT_DIR/junit-${label}.xml"
  cp "$JUNIT_SRC" "$junit_copy"

  # 3) Convert JUnit → CSV with package + flags columns
  csv_out="$OUT_DIR/${label}-times.csv"
  python3 "$PY_SCRIPT" "$junit_copy" "$package" "$flags" "$csv_out"

done < "$MATRIX_FILE"

echo
echo "All jobs processed; CSVs are in $OUT_DIR"

