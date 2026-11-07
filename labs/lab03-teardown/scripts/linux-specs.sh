#!/usr/bin/env bash
# Lab 3 — collect CPU, memory and disk facts on Linux (inside a VM this describes the VM).
# Run from the repository root:  bash labs/lab03-teardown/scripts/linux-specs.sh
out="labs/lab03-teardown/evidence/linux-specs.txt"
run() { echo "\$ $*"; "$@"; echo; }   # print the command, then its output
{
  echo "# Linux specs — $(date '+%Y-%m-%d %H:%M')"
  run lscpu
  run free -h
  run sudo dmidecode -t memory
  run lsblk -d -o NAME,MODEL,SIZE,ROTA,TRAN
  run df -h /
} > "$out" 2>&1
echo "saved to $out"
