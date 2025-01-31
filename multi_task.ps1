Write-Output "[+] Gathering System Information..."
Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsArchitecture, WindowsBuildLabEx | Out-String

Write-Output "[+] Listing Running Processes..."
Get-Process | Select-Object ProcessName, Id, CPU -First 10 | Out-String

Write-Output "[+] Checking Disk Space Usage..."
Get-PSDrive | Where-Object { $.Free -ne $null } | Select-Object Name, Used, Free, @{Name="Free(GB)";Expression={[math]::Round($.Free / 1GB, 2)}} | Out-String

Write-Output "[+] Fetching Network Configuration..."
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPv4Address, IPv6Address | Out-String

Write-Output "[+] Retrieving Installed Software (Top 10)..."
Get-WmiObject -Query "SELECT * FROM Win32_Product" | Select-Object Name, Version -First 10 | Out-String

Write-Output "[+] Checking Current Logged-In Users..."
Get-Process -IncludeUserName | Select-Object ProcessName, UserName -First 5 | Out-String

Write-Output "[+] Fetching Recent Event Logs..."
Get-WinEvent -LogName System -MaxEvents 5 | Select-Object TimeCreated, Id, Message | Out-String
