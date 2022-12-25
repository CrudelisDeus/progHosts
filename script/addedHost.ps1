$hosts = "C:\Windows\System32\drivers\etc\hosts"

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

# main-addDns
function get-main-addDns {
    clear
    Write-Host "[HOSTS]`n"
    Write-Host "[1] Add a new DNS entry"
    Write-Host "[2] Back"
    $userInput = Read-Host "`n[>]"
    switch($userInput) {
        1 {
            $newDNS = Read-Host "`n[*] Enter DNS"
            $newIP = Read-Host "[*] Enter IP"
            $newString = "$newIP $newDNS"
            Add-Content -Path $hosts -Value "$newString" -Force
            Write-Host "`n[!] Added to hosts file:" -NoNewline
            Write-Host " $newString"
            Write-Host "[!] Wait 10 seconds`n"
            Wait-Event -Timeout 10
            get-main
        }
        2 {
            get-main 
        }
        default {
            get-main-addDns
        }
    }
}

# get-main-view
function get-main-view {
    clear
    Write-Host "[HOSTS]`n"
    Get-Content $hosts
    Write-Host "`n[1] Back"
    $userInput = Read-Host "`n[>]"
    switch($userInput) {
        1 {
            get-main
        }
        default {
            get-main-view
        }
    }
}

# get-main-deleteStr
function get-main-deleteStr {
    clear
    Write-Host "[HOSTS]`n"
    Write-Host "[1] Deltete DNS entry"
    Write-Host "[2] Save to hosts file"
    Write-Host "[3] Back"
    $userInput = Read-Host "`n[>]"
    switch($userInput) {
        1 {
            Write-Host "`n[*] Enter DNS name"
            $userInput = Read-Host "[>]"
            #$LineStart = (((Get-Content $hosts | Select-String $userInput).LineNumber) - 1)
            #$MassFile = Get-Content $hosts
            #$MassFile = $MassFile[0..($LineStart - 1)]
            #$MassFile | Out-File $hosts -Force
            #Get-Content $hosts | % {$_ -replace "$userInput",""} | Out-File $hosts
            $Content = Get-Content $hosts
            $Content | Where{ $_ -notmatch $userInput } | Out-File $hosts
            Write-Host "`n[!] Deltete DNS entry: $userInput`n"
            Write-Host "[!] Wait 10 seconds`n"
            Wait-Event -Timeout 10
            get-main

        }
        2 {
            clear
            Write-Host "[HOSTS]`n"
            Write-Host "[!] save file C:\data\program\progHosts`n"
            Write-Host "[!] Wait 10 seconds`n"
            Get-Content $hosts | Out-File -FilePath C:\data\program\progHosts\save_hosts
            Wait-Event -Timeout 10
            get-main-deleteStr
        }
        3 {
            get-main
        }
        default {
            get-main-deleteStr
        }
    }

}

# main function
function get-main {
    clear
    Write-Host "[HOSTS]`n"
    Write-Host "[1] Add a new DNS entry"
    Write-Host "[2] View the hosts file"
    Write-Host "[3] Deltete DNS entry"
    Write-Host "[4] Unlock hosts file"
    Write-Host "[5] exit"
    $userInput = Read-Host "`n[>]"
    switch($userInput) {
        1 {
            get-main-addDns
        }
        2 {
            get-main-view
        }
        3 {
            get-main-deleteStr
        }
        4 {
            Get-Localuser -Name $env:UserName | Add-LocalGroupMember -Group 'Administrators'
            Get-Localuser -Name $env:UserName | Add-LocalGroupMember -Group 'Администраторы'
            get-main
        }
        5 {
            clear
        }
        default {
            get-main
        }
    }
}

#start
get-main