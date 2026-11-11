# Ticket 2 — four builds

All prices: shop.kz online-store price, 2026-11-11 and 2026-11-12 (per-row dates are in budget.csv). Row numbers refer to [budget.csv](budget.csv).
The memory numbers under "Load" are my estimates. I would measure them in Task Manager in the first week.

## Parts shared by all four

| Part | Model | KZT | Why the same for everyone |
| --- | --- | ---: | --- |
| SSD | WD Blue SN5100 1 TB, M.2 NVMe | 91,590 | 1 TB is a hard requirement; one model means one spare |
| Case | Ocypus Gamma C50 (mATX) | 11,690 | fits the 268 mm graphics card and the 133 mm cooler |
| CPU cooler | Ocypus Gamma A40 | 7,290 | the CPUs are OEM — no cooler in the box |
| Keyboard + mouse | Logitech MK120, RU/EN | 8,990 | wired, nothing to charge |

Platform for all four: **AM4 with DDR4.**
Alternative I did not take: AM5 with DDR5. AM5 will get new CPUs for longer, which fits "last a few years". But 32 GB of DDR5 is about 305,000 KZT and 32 GB of DDR4 is 139,990 KZT. Four AM5 machines would spend the reserve on memory alone, with nothing left for the designer's monitor or the UPS.

---

## Build 1 — accountant

**Load:** 1C and Excel all day, a browser with the bank and tax portals, a PDF reader. One or two heavy things at once, around 6–8 GB.

**Bottleneck:** not performance. Any modern 6-core CPU is idle here. The thing that can go wrong is the data: a power cut while 1C writes its database, or a stolen computer with the company's finances on it.

**Trade-off:** I gave her the cheapest CPU with graphics and only 16 GB, and spent the money on two things nobody asked for: Windows 11 **Pro** (+40,000 KZT over Home) for BitLocker disk encryption, and a UPS (24,590 KZT) so she can save and shut down in a power cut. She gets a 24-inch monitor, not a 27-inch one.

**Alternative not taken:** 32 GB and Windows Home for about the same money. Rejected: she would never fill 32 GB, but one corrupted database costs more than the whole computer.

| Part | Model | KZT |
| --- | --- | ---: |
| CPU | Ryzen 5 5500GT, 6 cores, built-in graphics | 79,190 |
| Board | MSI A520M-A Pro | 30,590 |
| Memory | 16 GB DDR4 (2×8 — two sticks, because built-in graphics uses system memory) | 76,990 |
| Power supply | Ocypus Gamma P550, 550 W | 18,990 |
| Monitor | ASUS VA249QG 23.8" IPS, flicker-free | 53,990 |
| OS | Windows 11 Pro | 122,990 |
| UPS | FSP FP 850 | 24,590 |
| Shared parts | SSD, case, cooler, keyboard set | 119,560 |

**Total: 526,890 KZT** (budget.csv, rows 2–12)

---

## Build 2 — sales manager

**Load:** CRM in a browser, 30–40 tabs, Excel, and about four hours of video calls a day, sometimes all at once. Around 11–12 GB.

**Bottleneck:** memory, not CPU. On 16 GB the machine is already close to full during a call, and it starts swapping to disk in front of a customer.

**Trade-off:** the same cheap CPU and board as the accountant, and the saving went into 32 GB (+63,000 KZT over 16 GB). The board has only two memory slots and both are now full, so there is no cheap memory upgrade later — I accepted that because 32 GB is enough for this role for years. Windows Home, not Pro.

**Alternative not taken:** a Ryzen 7 with 16 GB. Rejected: the CPU idles in this role, the memory does not.

**Left out of the request:** four hours of calls a day need a camera and a headset. A desktop has neither. Added a 1080p webcam (12,490) and a one-ear USB headset (19,590) — one ear stays free for the office.

| Part | Model | KZT |
| --- | --- | ---: |
| CPU | Ryzen 5 5500GT | 79,190 |
| Board | MSI A520M-A Pro | 30,590 |
| Memory | 32 GB DDR4 (2×16) | 139,990 |
| Power supply | Ocypus Gamma P550, 550 W | 18,990 |
| Monitor | ASUS VA249QG 23.8" IPS | 53,990 |
| OS | Windows 11 Home | 82,990 |
| Webcam + headset | Ugreen CM678, Jabra Evolve 20 Mono | 32,080 |
| Shared parts | SSD, case, cooler, keyboard set | 119,560 |

**Total: 557,380 KZT** (budget.csv, rows 14–25)

---

## Build 3 — web developer

**Load:** a code editor, three or four Docker containers (web server, database, cache), two browsers for testing, documentation and chat — all at the same time. Around 18–22 GB, and it grows with every project.

**Bottleneck:** memory first, CPU cores second (builds and tests use all of them), screen space third — code on one screen, the running site on the other.

**Trade-off:** no graphics card — the Ryzen 7 5700G has graphics built in and drives both monitors (DisplayPort + HDMI). An older platform (AM4, PCIe 3.0) instead of a new Ryzen 7 9700X with DDR5, which would cost about 181,000 KZT more for the same 32 GB (CPU 134,990 + board 44,590 + DDR5 304,990). Ubuntu instead of Windows: Docker runs natively on Linux, and it saves 122,990 KZT.

**Alternative not taken:** 64 GB now. Rejected because of this month's prices — but the board has four slots and two stay empty, so 64 GB later is one more kit. This is my answer to Question 1.

**Licence:** Ubuntu 24.04 LTS is free software with security updates until 2029. It is licensed, the licence just costs nothing.

| Part | Model | KZT |
| --- | --- | ---: |
| CPU | Ryzen 7 5700G, 8 cores, built-in graphics | 115,590 |
| Board | MSI B550M PRO-VDH, 4 memory slots | 47,690 |
| Memory | 32 GB DDR4 (2×16) | 139,990 |
| Power supply | Ocypus Gamma P550, 550 W | 18,990 |
| Monitors | 2 × AOC Q27B36X 27" IPS 2560×1440 | 173,980 |
| OS | Ubuntu 24.04 LTS | 0 |
| Shared parts | SSD, case, cooler, keyboard set | 119,560 |

**Total: 615,800 KZT** (budget.csv, rows 27–37)

---

## Build 4 — designer

**Load:** Photoshop and Illustrator with large files, Figma and a browser with references open next to them. Around 20 GB. She judges colour on the screen eight hours a day.

**Bottleneck:** the screen comes first — if the colours on the monitor are wrong, everything she sends to print is wrong, however fast the computer is. Then the graphics card (Photoshop filters and the canvas use it), then memory.

**Trade-off:** an RTX 5050 instead of an RTX 5060 (saves 63,600 KZT) and the old AM4 platform — and the money went to a 27-inch 4K IPS monitor with 99% sRGB. The monitor is a good office model, not a professional one: its stand only tilts and it has no hardware calibration.

**Alternatives not taken:**
- ASUS ProArt PA27UCGE, a professional 4K monitor — 487,790 KZT, more than half of her whole machine.
- A Ryzen 7 with built-in graphics and no graphics card — 245,990 KZT cheaper, but Photoshop's GPU features would crawl on a 4K screen.

**Power:** 65 W CPU + about 130 W graphics card. ASUS asks for a 550 W supply; I took 650 W so a stronger card fits later.

| Part | Model | KZT |
| --- | --- | ---: |
| CPU | Ryzen 7 5700X, 8 cores | 79,490 |
| Board | MSI B550M PRO-VDH | 47,690 |
| Memory | 32 GB DDR4 (2×16), two slots free | 139,990 |
| Graphics card | ASUS Prime RTX 5050 OC 8 GB | 245,990 |
| Power supply | DeepCool PF650D V2, 650 W | 27,690 |
| Monitor | ASUS VY27UQ 27" IPS 4K, 99% sRGB | 140,890 |
| OS | Windows 11 Home (Adobe does not run on Linux) | 82,990 |
| Shared parts | SSD, case, cooler, keyboard set | 119,560 |

**Total: 884,290 KZT** (budget.csv, rows 39–49)

---

## Grand total

526,890 + 557,380 + 615,800 + 884,290 = **2,584,360 KZT** of 3,000,000. Reserve: 415,640 KZT.
