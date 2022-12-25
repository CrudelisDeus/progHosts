PowerShell.exe -Command "New-Item "C:\data\program\progHosts" -ItemType Directory"
cls
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '.\script\addedHost.ps1'"
