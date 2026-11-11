# Ticket 2 — Kitting out the new office

Temirlan Jaxibekov · CYB26-5 · prices taken on 2026-11-11 and 2026-11-12

## 1. What was asked

> From: Daniyar K. (Director)
> Subject: computers for the new office
>
> We are opening the second office and need four computers — accountant,
> sales, web developer, designer. Budget 3,000,000 tenge for everything.
> Everyone says we should just buy the same four machines, is that right?
> Make sure they last a few years. Monitors included.

## 2. What was actually needed

**Four identical machines is the wrong answer.** The four people load a computer in four different ways, so the money has to go to four different parts:

| Role | What runs out first | Where the money went |
| --- | --- | --- |
| Accountant | nothing in performance — the risk is losing data | Windows 11 Pro (disk encryption) and a UPS |
| Sales | memory | 32 GB instead of 16 GB, webcam and headset |
| Web developer | memory, then CPU cores, then screen space | 8 cores, 32 GB, two monitors, 4 memory slots |
| Designer | the screen and the graphics card | 4K 99% sRGB monitor, RTX 5050 |

I checked it with numbers. Four copies of the designer machine cost 4 × 884,290 = **3,537,160 KZT** — 537,160 over the budget. Four copies of the accountant machine fit the budget, but then the designer has no graphics card and no colour-accurate screen, and the developer has 16 GB and one small monitor. "Identical" either breaks the budget or leaves two people with the wrong tool.

One thing in the director's idea is right, and I kept it: **the same parts where the load does not matter.** All four machines use the same SSD, case, CPU cooler, keyboard set, and one of two motherboards. Fewer different parts means easier repairs and one spare fits everyone.

**What the request left out**

- **What "for everything" covers.** Monitors are mentioned. The operating system, keyboards, mice, a webcam for the sales calls, cables, delivery and assembly are not.
- **Software.** 1C, Microsoft Office and Adobe subscriptions can cost as much as a computer. Nothing is said about them.
- **What "designer" means.** Print and web graphics need a good screen. Video and 3D need a much stronger graphics card and more memory.
- **What the developer and the accountant need to run.** Accounting software in Kazakhstan usually needs Windows. A web developer may work better on Linux.
- **"A few years"** — three or five? It changes whether an end-of-line platform is acceptable.
- **Backups and power cuts.** Nobody asked, but the accountant's database is the one thing in this office that cannot be bought again.
- **Who puts the machines together** and who is called when one breaks.

**What I would ask Daniyar, and what I assumed instead**

| Question | My assumption |
| --- | --- |
| Is the 3,000,000 for hardware only, or software too? | Hardware, operating systems and peripherals. 1C, Office and Adobe are a separate budget. |
| What does the designer make? | Print and web graphics (Photoshop, Illustrator, Figma). No video editing, no 3D. |
| Which accounting software? | 1C, so Windows is required. |
| Does the developer need Windows? | No. Web development with Docker, so Ubuntu LTS. If I am wrong, Windows 11 Pro (122,990 KZT) comes out of the reserve. |
| How many years is "a few"? | Three to four years. |
| Do we already have keyboards, mice, cables? | No, everything is new. |
| Who assembles and installs? | I do. No assembly fee in the budget. |
| Desktops or laptops? | Desktops — he wrote "computers" and "monitors included". |

## 3. What I did

1. **Wrote the load for each person first**, before choosing any part: what they run, how many things at once, which resource runs out. This is in [builds.md](builds.md).
2. **Checked prices at one vendor that delivers in Kazakhstan** — shop.kz (White Wind), online-store price, on 2026-11-11 and 2026-11-12 (the date of each price is in budget.csv). One vendor means one delivery and one place for warranty.
3. **Found that memory decides the platform this month.** 32 GB of DDR5 costs about 305,000 KZT; 32 GB of DDR4 costs 139,990 KZT. That is about 165,000 KZT per machine. So I chose the older AM4 platform with DDR4 for all four and spent the difference on the bottlenecks. This is the biggest trade-off in the ticket and it is explained in builds.md.
4. **Checked compatibility by hand, as in Lab 3:** CPU socket ↔ board socket (all AM4), memory type ↔ board (all DDR4), M.2 slot ↔ NVMe SSD, graphics card length (268 mm) ↔ case limit (340 mm), cooler height (133 mm) ↔ case limit (160 mm), power ↔ power supply. PCPartPicker lists are in [evidence/pcpartpicker-links.md](evidence/pcpartpicker-links.md).
5. **Put every part in [budget.csv](budget.csv)** with price, link and date.

**Budget**

| Machine | Total, KZT | budget.csv rows |
| --- | ---: | --- |
| Accountant | 526,890 | 2–12 |
| Sales | 557,380 | 14–25 |
| Web developer | 615,800 | 27–37 |
| Designer | 884,290 | 39–49 |
| **Grand total** | **2,584,360** | 51 |
| Budget | 3,000,000 | 52 |
| Reserve | 415,640 (13.9%) | 53 |

Every machine has at least 16 GB of memory, a 1 TB SSD, a licensed operating system and a monitor.

**Why I left a reserve and did not spend it.** Prices moved while I was looking: the same 32 GB kit cost 146,990 KZT in the afternoon and 139,990 KZT at night, and nine of my 22 prices changed between the first look and the screenshots. The pre-built HP went from 729,190 to 799,990 KZT overnight when the 11.11 sale ended. The reserve also covers what the request forgot: delivery, a DisplayPort cable for the second monitor, case fans, an external disk for the accountant's backups.

### Question 1 — Which machine do I upgrade first, in eighteen months?

**The developer's, and the part is memory: from 32 GB to 64 GB.** His load grows fastest — every new project adds containers. I chose his board with four memory slots on purpose, and two are empty, so the upgrade is one more 2×16 GB kit and ten minutes of work. I did not buy 64 GB now because memory is unusually expensive this month.

### Question 2 — The same four as pre-built machines

Pre-built machines from the same shop that meet the hard requirements (16 GB, 1 TB SSD), prices on 2026-11-12, full table in [prebuilt.csv](prebuilt.csv):

| Role | Pre-built | KZT |
| --- | --- | ---: |
| Accountant | HP OmniDesk AI M03-0020ci — Core Ultra 5 225, 32 GB, 1 TB, Windows 11 Home | 799,990 |
| Sales | the same HP | 799,990 |
| Developer | HP OmniDesk AI M03-0019ci — Core Ultra 7 265, 32 GB, 1 TB, Windows 11 Home | 889,990 |
| Designer | WW-KZ — Core i5-14400, RTX 5060 8 GB, 16 GB, 1 TB, no OS | 791,090 |
| Designer | + Windows 11 Home | 82,990 |
| **Total, system units only** | | **3,364,050** |

My four system units (without monitors and peripherals) cost 2,068,880 KZT. The pre-built ones cost **1,295,170 KZT more** and are over the whole budget before a single monitor is bought.

- **The company gains:** one warranty for the whole box, Windows already installed on the HP machines, no assembly time and no risk that I make a mistake during assembly.
- **The company loses:** about 1.3 million tenge; the choice of parts (the designer's pre-built has only 16 GB, the accountant pays for 32 GB she does not need); and the upgrade path, because brand-name office PCs often use their own boards and power supplies.

Pre-built also repeats the director's mistake: the cheapest pre-built that passes the hard requirements is the same HP for three of the four people.

### Question 3 — Who complains within a month, and about what?

**The designer.** My weakest assumption is that she only does print and web graphics. If she also edits video or works with very large files, the RTX 5050 with 8 GB of video memory and the older 8-core CPU will be slow on exports, and she will say so. The second complaint will be the monitor stand: it only tilts, it does not go up and down. The fix is ready: the reserve covers an RTX 5060 (+63,600 KZT) or a monitor arm.

## 4. Evidence

- [budget.csv](budget.csv) — every part, price in KZT, link to the shop page, date. Proves the total is under 3,000,000.
- [prebuilt.csv](prebuilt.csv) — the pre-built machines for Question 2, with links and date.
- [builds.md](builds.md) — load, bottleneck, trade-off and the alternative I did not take, for each machine.
- [evidence/pcpartpicker-links.md](evidence/pcpartpicker-links.md) — one PCPartPicker list per build. Proves socket, memory type and power fit. PCPartPicker has no tenge prices; I used it only for compatibility.
- [evidence/vendor-quotes/](evidence/vendor-quotes/) — a screenshot of each price with the shop address visible; the date is in the file name. Proves each number in budget.csv was real on that day.

## 5. What I would do differently

- **I would not buy the memory on the same day as everything else.** Memory is half of the price problem in this ticket. I would buy the machines with the memory I chose, and watch DDR4 prices for a month before buying the developer's second kit.
- **I would ask the designer one question before ordering:** "do you edit video?" Her whole build depends on an assumption I could not check.
- **I would check two things in the shop before paying:** that the A520 boards have a BIOS new enough for the Ryzen 5 5500GT, and what the real power of the UPS is — the shop page for the FSP FP 850 does not state VA or watts, only "19 minutes at 90 W".
- AM4 is an end-of-line platform. If DDR5 prices fall, I would put the designer on AM5 instead, because her machine is the one most likely to need a new CPU.
