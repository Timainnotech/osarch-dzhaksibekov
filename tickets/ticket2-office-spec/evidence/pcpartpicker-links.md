# PCPartPicker lists

PCPartPicker does not show prices in tenge. I used it only to check compatibility (socket, memory type, M.2, size) and the estimated power draw. Prices come from shop.kz — see budget.csv.

The lists hold the parts that decide compatibility: CPU, board, memory, SSD and graphics card. Case, cooler and power supply (Ocypus, DeepCool) are checked by hand in the table at the bottom.

| Build | CPU · board · memory · SSD · graphics | Link | Estimated wattage | Compatibility notes shown |
| --- | --- | --- | --- | --- |
| 1 — accountant | Ryzen 5 5500GT · MSI A520M-A PRO · 2×8 GB DDR4-3200 · WD Blue SN5100 1 TB · built-in | https://pcpartpicker.com/list/pG4y8Z | 146 W | Board supports this CPU from BIOS 7C96v1G — an older BIOS must be updated first |
| 2 — sales | Ryzen 5 5500GT · MSI A520M-A PRO · 2×16 GB DDR4-3200 · WD Blue SN5100 1 TB · built-in | https://pcpartpicker.com/list/bpsqNp | 158 W | Same BIOS note (7C96v1G) |
| 3 — developer | Ryzen 7 5700G · MSI B550M PRO-VDH · 2×16 GB DDR4-3200 · WD Blue SN5100 1 TB · built-in | https://pcpartpicker.com/list/xR362k | 158 W | Board supports this CPU from BIOS 7C95v28 |
| 4 — designer | Ryzen 7 5700X · MSI B550M PRO-VDH · 2×16 GB DDR4-3200 · WD Blue SN5100 1 TB · ASUS Prime RTX 5050 8 GB | https://pcpartpicker.com/list/3sN3W9 | 288 W | CPU has no cooler in the box (I add the Ocypus A40); board supports this CPU from BIOS 7C95v2A |

No incompatibilities in any list — only the warnings above. All were made on 2026-11-11.

The 32 GB kit in lists 2–4 is TEAMGROUP Elite DDR4-3200 CL22 2×16 GB: PCPartPicker does not have the GeIL Pristine kit I buy, and this one has the same type, speed, timings and size.

Power check: the biggest estimate is 288 W (designer) against a 650 W supply, and 158 W against 550 W for the others.

What I checked by hand as well (Lab 3 method):

| Check | Result |
| --- | --- |
| CPU socket ↔ board socket | all AM4 |
| Board memory type ↔ memory | all DDR4 DIMM |
| M.2 slot ↔ NVMe SSD | every board has an M.2 PCIe slot. On builds 1–3 the SSD runs at PCIe 3.0 speed, because these CPUs and the A520 board are PCIe 3.0. It is still far faster than the load needs. |
| Built-in graphics ↔ board video outputs | 5500GT and 5700G have graphics; A520M-A PRO has HDMI + DVI-D; B550M PRO-VDH has DisplayPort + HDMI for the two monitors |
| Graphics card ↔ case and power | 268 mm card, case allows 340 mm; one 8-pin plug, the PF650D has it; ASUS asks for 550 W, I have 650 W |
| Cooler ↔ case | 133 mm cooler, case allows 160 mm |
| Windows 11 ↔ CPU | Ryzen 5000 is on Microsoft's supported list (TPM 2.0 in firmware) |
