# Lab 0 — Inventory your own machine

Pair: Джаксибеков Темирлан
Machine: macOS Host (MacBook Pro)
Date: 11.10.2026

## What I did
Ran system diagnostic commands in the macOS Terminal to harvest hardware specifications.

## Result

| What | Value | Where I got it |
| :--- | :--- | :--- |
| CPU Model | Intel Core i5-8257U CPU @ 1.40GHz | `sysctl -a \| grep machdep.cpu.brand_string` |
| CPU Core Count | 4 | `sysctl -a \| grep machdep.cpu.core_count` |
| CPU Thread Count | 8 | `sysctl -a \| grep machdep.cpu.thread_count` |
| Total Memory | 8 GB | `system_profiler SPHardwareDataType \| grep "Memory:"` |
| Memory Modules Count | 2 modules (Dual Channel) | `system_profiler SPMemoryDataType` |
| Memory Speed | 2133 MHz LPDDR3 | `system_profiler SPMemoryDataType` |
| Disk Model | APPLE SSD AP0256M | `system_profiler SPStorageDataType` |
| Disk Type | NVMe SSD | `system_profiler SPStorageDataType` |
| Free Space | 12 Gi free | `df -h /` |
| Firmware Type | UEFI / Apple EFI | Mac Hardware Specification |
| Firmware Version & Date| 2103.100.6.0.0 (iBridge: 23.16.15067.0.0,0) | `system_profiler SPHardwareDataType \| grep "Version"` |
| Hardware Virtualization| Present and Enabled | `sysctl kern.hv_support` |

## What did not work the first time
Linux inventory utilities like `lscpu` are missing on macOS, so we had to research BSD-specific keys under `sysctl`. Also, running `df -h` without parameters printed multiple hidden system mount points, which required isolating the root path via `df -h /` to correctly see the actual free space for future virtual machines.

## Evidence
osarch-dzhaksibekov/
└── labs/
    └── lab00-inventory/
        ├── README.md ← the report: what you did, what came out
        └── evidence/ ← command output as .txt, screenshots as .png
            ├── cpu.txt — proves CPU model, core and thread counts
            ├── memory.txt — proves total memory, modules and speed
            └── disk.txt — proves disk type, model and free volume space
