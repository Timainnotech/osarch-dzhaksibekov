# Lab 3 — collect CPU, memory and disk facts on Windows (PowerShell).
# Run from the repository root:
#   powershell -ExecutionPolicy Bypass -File labs\lab03-teardown\scripts\windows-specs.ps1
$out = "labs\lab03-teardown\evidence\windows-specs.txt"
$cmds = @(
  'Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed | Format-List',
  'Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory | Format-List',
  'Get-CimInstance Win32_PhysicalMemory | Select-Object Capacity,Speed,Manufacturer,PartNumber | Format-Table -AutoSize',
  'Get-PhysicalDisk | Select-Object FriendlyName,MediaType,BusType,Size | Format-Table -AutoSize',
  'Get-Volume | Format-Table -AutoSize'
)
"# Windows specs — $(Get-Date -Format 'yyyy-MM-dd HH:mm')" | Out-File $out -Encoding utf8
foreach ($c in $cmds) {
  "`nPS> $c" | Out-File $out -Append -Encoding utf8          # the command line
  Invoke-Expression $c | Out-String | Out-File $out -Append -Encoding utf8   # its output
}
"saved to $out"
