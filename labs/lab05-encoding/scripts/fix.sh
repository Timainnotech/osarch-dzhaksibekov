#!/bin/sh
# Lab 5: convert staff-broken.csv from RK1048 (KZ-1048) to UTF-8
# Run from labs/lab05-encoding/:  sh scripts/fix.sh
in=evidence/staff-broken.csv
out=evidence/staff-fixed.csv
# 1) Decode RK1048 -> UTF-8. GNU iconv knows RK1048; if this iconv does not
#    (old macOS iconv), use Python's built-in codec "kz1048" (same table).
if iconv -l 2>/dev/null | grep -qi 'RK1048'; then
  iconv -f RK1048 -t UTF-8 "$in" > "$out"
else
  python3 -c 'import sys; sys.stdout.buffer.write(open(sys.argv[1],"rb").read().decode("kz1048").encode("utf-8"))' "$in" > "$out"
fi
# 2) Keep CRLF: the source is CRLF and Excel on Windows expects it.
# 3) Add a UTF-8 BOM so Excel detects UTF-8 on double-click.
printf '\357\273\277' | cat - "$out" > "$out.tmp" && mv "$out.tmp" "$out"
