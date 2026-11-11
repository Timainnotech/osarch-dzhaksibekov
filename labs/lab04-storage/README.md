# Lab 4 — Partition, mirror, fail, recover

Pair: Temirlan Jaxibekov / Daiana · CYB26-5
Driver: Jaxibekov for the Linux half, Daiana for the Windows half
Machines: MacBook Pro (Intel, 8 GB RAM), UTM (QEMU), Ubuntu 26.04.1 LTS guest `lab02` from Lab 2 — Linux half · Daiana's Windows PC — Windows half
Date: 11.11.2026 (Linux), __.11.2026 (Windows)

## Windows

The Windows guest `lab02_win` does not start on my Mac, so this half was done on Daiana's Windows machine with one extra 1 GB virtual disk.

How the disk was added: a 1 GB virtual disk file (`C:\lab04.vhd`) created and attached with `diskpart`, so Windows sees it as a new empty disk. The disk number on her machine may differ from 1; the commands below use the number that `Get-Disk` showed for the new RAW disk.

```powershell
Get-Disk
Initialize-Disk -Number 1 -PartitionStyle GPT
New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel LAB04
Get-Disk | Select Number, FriendlyName, PartitionStyle, Size
Get-Volume | Where FileSystemLabel -eq 'LAB04'
```

```text
INSERT: Daiana's output of the last two commands
```

**MBR or GPT:** GPT. Windows 11 boots with UEFI, and UEFI uses GPT, so the new disk has the same style as the system disk. GPT also keeps a second copy of the partition table at the end of the disk and checks both with a checksum, while MBR has one copy, a 2 TiB limit and only four primary partitions.

## Linux — layout before and after

Three 1 GB virtual disks were added in UTM while the VM was off. In the guest they are `sdb`, `sdc`, `sdd`; the system disk is `sda`.

### Before

```text
$ lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
NAME                       SIZE TYPE FSTYPE      MOUNTPOINTS
loop0                     66.8M loop squashfs    /snap/core24/1643
loop1                     66.8M loop squashfs    /snap/core24/2124
loop2                      1.5M loop squashfs    /snap/hwctl/123
loop3                     50.1M loop squashfs    /snap/snapd/27710
loop4                      1.5M loop squashfs    /snap/hwctl/131
sda                         20G disk             
├─sda1                     953M part vfat        /boot/efi
├─sda2                     1.8G part ext4        /boot
└─sda3                    17.3G part LVM2_member 
  └─ubuntu--vg-ubuntu--lv   10G lvm  ext4        /
sdb                          1G disk             
sdc                          1G disk             
sdd                          1G disk             
sr0                       1024M rom              
```

### After

```text
$ lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS
NAME                       SIZE TYPE  FSTYPE            MOUNTPOINTS
loop0                     66.8M loop  squashfs          /snap/core24/1643
loop1                     66.8M loop  squashfs          /snap/core24/2124
loop2                      1.5M loop  squashfs          /snap/hwctl/123
loop3                     50.1M loop  squashfs          /snap/snapd/27710
loop4                      1.5M loop  squashfs          /snap/hwctl/131
sda                         20G disk                    
├─sda1                     953M part  vfat              /boot/efi
├─sda2                     1.8G part  ext4              /boot
└─sda3                    17.3G part  LVM2_member       
  └─ubuntu--vg-ubuntu--lv   10G lvm   ext4              /
sdb                          1G disk                    
└─sdb1                    1022M part  linux_raid_member 
  └─md0                   1021M raid1 ext4              /mnt/mirror
sdc                          1G disk                    
└─sdc1                    1022M part  linux_raid_member 
sdd                          1G disk                    
└─sdd1                    1022M part  linux_raid_member 
  └─md0                   1021M raid1 ext4              /mnt/mirror
sr0                       1024M rom                     
```

`md0` is now on `sdb1` and `sdd1`. `sdc1` still has the RAID label, but it is no longer in the array.

## What I did

Partition the three disks, one RAID partition on each:

```bash
for d in b c d; do
  sudo parted -s /dev/sd$d mklabel gpt mkpart primary 1MiB 100% set 1 raid on
done
```

Build the mirror from two of them, wait for the first sync, save the healthy state:

```bash
sudo mdadm --create /dev/md0 --level=1 --raid-devices=2 --run /dev/sd[bc]1
sudo mdadm --wait /dev/md0
cat /proc/mdstat
sudo mdadm --detail /dev/md0
```

File system, mount, proof file, checksum:

```bash
sudo mkfs.ext4 -qL mirror /dev/md0
sudo mkdir /mnt/mirror
sudo mount /dev/md0 /mnt/mirror
sudo chown $USER: /mnt/mirror
cd /mnt/mirror
echo "Lab 4 proof file - Jaxibekov - $(date)" > proof.txt
head -c 20M /dev/urandom > random.bin
sha256sum proof.txt random.bin
```

Fail one disk on purpose, save the degraded state, take the checksum again:

```bash
sudo mdadm /dev/md0 --fail /dev/sdc1
sudo mdadm /dev/md0 --remove /dev/sdc1
cat /proc/mdstat
sudo mdadm --detail /dev/md0
sha256sum proof.txt random.bin
```

Add the third disk, wait for the rebuild, save the rebuilt state:

```bash
sudo mdadm /dev/md0 --add /dev/sdd1
sudo mdadm --wait /dev/md0
cat /proc/mdstat
sudo mdadm --detail /dev/md0
```

Each output was saved at the moment of that state, with the command as the first line of the file.

How I failed the disk: with `mdadm --fail`, then `--remove`.

## Result — three states

| State | /proc/mdstat | mdadm --detail | File |
| --- | --- | --- | --- |
| Healthy | `sdc1[1] sdb1[0]` `[2/2] [UU]` | `State : clean`, 2 active devices | [evidence/array-healthy.txt](evidence/array-healthy.txt) |
| Degraded | `sdb1[0]` `[2/1] [U_]` | `State : clean, degraded`, 1 active device, slot 1 `removed` | [evidence/array-degraded.txt](evidence/array-degraded.txt) |
| Rebuilt | `sdd1[2] sdb1[0]` `[2/2] [UU]` | `State : clean`, 2 active devices, `sdd1` in slot 1 | [evidence/array-rebuilt.txt](evidence/array-rebuilt.txt) |

The array kept the same UUID (`f8636930:be348ee1:7fd15b71:7c8b20b4`) in all three states — it is one array that lost a disk and got a new one.

Checksums before the failure:

```text
758597265fc854d152db6b5f5d146da7767b02f26f3183db9a692e7656634d7f  proof.txt
067aa44b62a64cf0f6e0d51d18271693768fc6749209c68029621aff9ce6173a  random.bin
```

Checksums with one disk gone:

```text
758597265fc854d152db6b5f5d146da7767b02f26f3183db9a692e7656634d7f  proof.txt
067aa44b62a64cf0f6e0d51d18271693768fc6749209c68029621aff9ce6173a  random.bin
```

They match: both files were readable and unchanged while the mirror was running on one disk.

## RAID is not a backup

*Your colleague deleted the wrong file from the mirror an hour ago. Does RAID 1 help? Why?*

No. RAID 1 copies every change to both disks at the same moment, so the delete was written to both of them and the file is gone from both. A mirror protects against a disk that dies, not against a mistake or a virus; to get the file back you need a backup or a snapshot made before the delete.

## What did not work the first time

**Wrong symbols in the VM console.** What I saw: I typed a command with `#` and `\` in the Ubuntu console and got `£` and `#` on the screen, and `|` and `"` were on the wrong keys too, so the commands failed. What it turned out to be: the guest console was using the British keyboard map (`gb`), while my keyboard is US. The VM was installed that way in Lab 2 and I had not noticed, because short commands like `ls` use only letters. What I did: `sudo loadkeys us`, then typed a test line with all the symbols before going on. It lasts until reboot; the permanent fix is `sudo dpkg-reconfigure keyboard-configuration`.

**Windows VM on the Mac.** `lab02_win` shows "unavailable" in UTM and does not start. We did not fix it; the Windows half was done on Daiana's machine instead.

## Evidence

- [evidence/lsblk-before.txt](evidence/lsblk-before.txt) — three empty 1 GB disks before I touched them
- [evidence/array-healthy.txt](evidence/array-healthy.txt) — mirror of sdb1 + sdc1, `State : clean`, `[UU]`
- [evidence/checksum-before.txt](evidence/checksum-before.txt) — SHA-256 of both files on the healthy mirror
- [evidence/array-degraded.txt](evidence/array-degraded.txt) — sdc1 failed and removed, `clean, degraded`, `[U_]`
- [evidence/checksum-after-failure.txt](evidence/checksum-after-failure.txt) — the same SHA-256 sums with one disk gone: the data survived
- [evidence/array-rebuilt.txt](evidence/array-rebuilt.txt) — sdd1 added, rebuild finished, `[UU]` again; `lsblk` after the rebuild
