#!/usr/bin/env python3
import sys
import csv
import xml.etree.ElementTree as ET
from pathlib import Path

if len(sys.argv) < 4:
    print(
        f"Usage: {sys.argv[0]} <junit.xml> <package> <flags> [output.csv]",
        file=sys.stderr,
    )
    sys.exit(1)

junit_path = Path(sys.argv[1])
package = sys.argv[2]
flags = sys.argv[3]
out_path = Path(sys.argv[4]) if len(sys.argv) > 4 else junit_path.with_suffix(".csv")

tree = ET.parse(junit_path)
root = tree.getroot()

rows = []
# JUnit usually has <testsuite> with nested <testcase>
for suite in root.iter("testsuite"):
    suite_name = suite.get("name", "")
    for case in suite.iter("testcase"):
        classname = case.get("classname", "")
        name = case.get("name", "")
        time_str = case.get("time") or "0"
        try:
            time = float(time_str)
        except ValueError:
            time = 0.0
        rows.append((time, package, flags, suite_name, classname, name))

# Slowest first
rows.sort(key=lambda r: r[0], reverse=True)

with out_path.open("w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(
        ["time_seconds", "package", "flags", "suite", "classname", "name"]
    )
    for row in rows:
        writer.writerow(row)

print(f"Wrote {len(rows)} rows to {out_path}")
