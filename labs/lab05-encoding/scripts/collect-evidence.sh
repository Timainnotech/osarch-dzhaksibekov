#!/bin/sh
# Lab 5: record every diagnosis step with the command above its output.
# Run from labs/lab05-encoding/:  sh scripts/collect-evidence.sh
set -e
b=evidence/staff-broken.csv
f=evidence/staff-fixed.csv

{ echo "\$ file $b"; file "$b"; } > evidence/file-before.txt
{ echo "\$ od -A x -t x1 -N 64 $b"; od -A x -t x1 -N 64 "$b"; } > evidence/hexdump-before.txt
{ echo "\$ cat -v $b | head -3"; cat -v "$b" | head -3; } > evidence/line-endings-before.txt

# First attempt: Windows-1251 (Russian OK, Kazakh letters broken)
{ echo "\$ iconv -f WINDOWS-1251 -t UTF-8 $b | head -5"; iconv -f WINDOWS-1251 -t UTF-8 "$b" | head -5; } > evidence/first-attempt-cp1251.txt

sh scripts/fix.sh

{ echo "\$ file $f"; file "$f"; } > evidence/file-after.txt
{ echo "\$ od -A x -t x1 -N 16 $f"; od -A x -t x1 -N 16 "$f"; } >> evidence/file-after.txt
{ echo "\$ cat $f"; cat "$f"; } > evidence/fixed-cat.txt

echo "Done. Evidence:"; ls -1 evidence
