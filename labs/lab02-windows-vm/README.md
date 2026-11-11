# Lab 2 — A Windows guest, and a network between them

Pair: Temirlan Jaxibekov (individual — no lab partner)
Machine: MacBook Pro 13" (Intel Core i5-8257U, 4 cores / 8 threads, 8 GB LPDDR3, 121 GB SSD), macOS · hypervisor: UTM (QEMU + Apple Hypervisor.framework)
Guests: Ubuntu Server 26.04.1 LTS (UTM VM `lab02`, hostname `lab02`, 2 vCPU, 2 GB) + Windows 11 Enterprise evaluation (`lab02_win`)
Date: 07–08.11.2026

## What I did
1. Downloaded Windows 11 Enterprise evaluation (free for 90 days, no product key). Licence: https://www.microsoft.com/en-us/evalcenter/evaluate-windows-11-enterprise
2. Created `lab02_win` in UTM (Windows template, "Install Windows 10 or higher" + SPICE tools; screenshots: evidence/windows-vm-qemu-uefi-tpm.jpg, evidence/windows-vm-network-shared.jpg): 2 vCPU (half of my 4 physical cores), 4 GB RAM (Windows 11 minimum), 64 GB disk (thin — the qcow2 file grows only as data is written), UEFI + Secure Boot + emulated TPM 2.0 (all three are required by Windows 11).
3. Network mode: **Shared Network** (UTM's NAT) on **both** guests. Why: both guests must reach each other **and** the internet. Shared Network puts every guest on one private subnet behind the Mac's NAT, so they see each other and go out through the Mac. Bridged was not used: on the campus Wi-Fi unknown MAC addresses are dropped, and a laptop on Wi-Fi often cannot bridge at all. Host-only gives no internet.
4. Ping Ubuntu → Windows timed out because Windows Defender Firewall blocks inbound ICMP echo requests (type 8) on a **Public** network profile (`Get-NetConnectionProfile` → `<NetworkCategory>`). Fixed with one rule that allows exactly ping — the firewall stays on:
   `New-NetFirewallRule -DisplayName "Allow ping in (ICMPv4)" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow`
5. Overcommitment: set <5> GB (Ubuntu) + <5> GB (Windows) = <10> GB promised on an 8 GB host, then returned to 2 GB + 4 GB.

## Network diagram
```
              Internet
                 |
     MacBook Pro  <host IP>  (Wi-Fi)
                 |
   [UTM Shared Network (NAT) · 10.211.55.0/24]
           /                     \
   lab02 (Ubuntu)             lab02-windows
   10.211.55.5                <IP>
```

## Result
| | Before (guests off) | After (both guests on, 10 GB promised) |
|---|---|---|
| Memory used | … GB | … GB |
| Memory pressure | … | … |
| Swap used | … GB | … GB |
| What I noticed | — | <stutter? frozen windows? for how long?> |

## What did not work the first time
<At least one real thing: what I saw, what it turned out to be, what I did.
For example: "Ping from Ubuntu to Windows timed out — the Windows firewall blocks ICMP echo on a Public network; added one inbound ICMPv4 type 8 rule instead of turning the firewall off.">

## Evidence
- [evidence/ipconfig-windows.txt](evidence/ipconfig-windows.txt) — Windows address
- [evidence/ip-addr-linux.txt](evidence/ip-addr-linux.txt) — Ubuntu address (10.211.55.5 on enp0s1); screenshot of the console: [evidence/ubuntu-ip-addr-uname.jpg](evidence/ubuntu-ip-addr-uname.jpg)
- [evidence/ping-both-ways.txt](evidence/ping-both-ways.txt) — both directions and the internet
- [evidence/host-memory-before.png](evidence/host-memory-before.png) — host memory, guests off
- [evidence/host-memory-after.png](evidence/host-memory-after.png) — host memory, both guests overcommitted
