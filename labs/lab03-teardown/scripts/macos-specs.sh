#!/usr/bin/env bash
# Lab 3 — collect CPU, memory and disk facts on macOS.
# Run from the repository root:  bash labs/lab03-teardown/scripts/macos-specs.sh
out="labs/lab03-teardown/evidence/macos-specs.txt"
run() { echo "\$ $*"; "$@"; echo; }   # print the command, then its output
{
  echo "# macOS specs — $(date '+%Y-%m-%d %H:%M')"
  run sysctl -n machdep.cpu.brand_string
  run sysctl hw.physicalcpu hw.logicalcpu
  run sysctl hw.memsize
  run system_profiler SPMemoryDataType
  run diskutil info disk0
  run df -h /
} > "$out" 2>&1
echo "saved to $out"
