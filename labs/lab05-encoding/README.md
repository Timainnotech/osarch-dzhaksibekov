# Lab 5 — Encoding forensics

Name: Temirlan Jaxibekov · ID:070316502288 · Pair: Asanali (data from his machine is marked "partner's data")
Machine: Intel MacBook Pro 2019 (macOS) · Tools: `file`, `od`, `cat -v`, `iconv` / Python `kz1048` codec

## What I received
`evidence/staff-broken.csv` — staff list from HR. In Excel and in the terminal the names are garbled; Kazakh letters (Ә, Қ, Ұ, Ө, Ү) are broken worst. Separator: `;`.

## Diagnosis (before the fix)
| Question | Answer | Evidence |
|---|---|---|
| What does `file` say? | `Non-ISO extended-ASCII text, with CRLF line terminators` — a single-byte code page, `file` cannot name which one | `evidence/file-before.txt` |
| BOM? | **No** — the file starts with `49 44` = `ID`, not `EF BB BF` / `FF FE` | `evidence/hexdump-before.txt` |
| Line endings | **CRLF** — `0d 0a` at offset 0x24 in the dump, `^M` at line ends in `cat -v` | `evidence/hexdump-before.txt`, `evidence/line-endings-before.txt` |
| Encoding | **RK1048 (KZ-1048)** — the Kazakh variant of Windows-1251 | see below |

Why RK1048: bytes `d4 e0 ec e8 eb e8 ff` read as Windows-1251 give `Фамилия`, so it is a Cyrillic single-byte page. But Windows-1251 breaks the Kazakh names: `Јбдірахманова`, `Ќасымов`, `Нўрлан` (`evidence/first-attempt-cp1251.txt`). The key byte is `a3` at offset 0x2a (first letter of the surname in row 101): in Windows-1251 it is `Ј`, in RK1048 it is `Ә`. Decoding with RK1048 makes both Russian and Kazakh names correct.

## Fix — `scripts/fix.sh`
- Decode RK1048 → UTF-8 with `iconv` (or Python's built-in `kz1048` codec if the local `iconv` has no RK1048, e.g. old macOS iconv).
- **Keep CRLF** — the source is CRLF and the file is for Excel/Windows users.
- **Add a UTF-8 BOM** — without it Excel on a double-click may read UTF-8 as ANSI/cp1251 and break the text again.

Run from this folder: `sh scripts/fix.sh`. All evidence is produced by `sh scripts/collect-evidence.sh` (each file has the command above its output). The original `staff-broken.csv` is not modified.

## Verification
- `evidence/file-after.txt`: `Unicode text, UTF-8 (with BOM) text, with CRLF line terminators`; first bytes `ef bb bf 49 44 3b d0 a4 …` = BOM, then `ID;Ф…` in UTF-8.
- `evidence/fixed-cat.txt`: every name reads correctly, for example Әбдірахманова, Қасымов, Нұрлан.
- `evidence/opens-correctly.png`: three applications side by side — Google Sheets (CSV import, separator `;`), TextEdit, and `cat` in the macOS terminal. Excel and LibreOffice are not installed on my Mac; the BOM is added for the Excel double-click case.

## What did not work the first time
My first guess was Windows-1251, because the Russian header decoded fine. The Kazakh surnames stayed broken (`Јбдірахманова`, `Ќасымов`) — saved in `evidence/first-attempt-cp1251.txt`. So the code page differs only in the Kazakh letters, which points to RK1048.

## AI use
| Tool | What for | What I checked myself |
|---|---|---|
| Claude | Draft of README and scripts | Ran both scripts on my Mac, compared the bytes in the dumps, can explain every line |
