# PowerShell script performing multiple benign activities

Write-Output "[+] Gathering System Information..."
Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsArchitecture, WindowsBuildLabEx

Write-Output "[+] Listing Running Processes..."
Get-Process | Select-Object ProcessName, Id, CPU -First 10

Write-Output "[+] Checking Disk Space Usage..."
Get-PSDrive | Where-Object { $_.Free -ne $null } | Select-Object Name, Used, Free, @{Name="Free(GB)";Expression={[math]::Round($_.Free / 1GB, 2)}}

Write-Output "[+] Fetching Network Configuration..."
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPv4Address, IPv6Address

Write-Output "[+] Retrieving Installed Software (Top 10)..."
Get-WmiObject -Query "SELECT * FROM Win32_Product" | Select-Object Name, Version -First 10

Write-Output "[+] Checking Current Logged-In Users..."
Get-Process -IncludeUserName | Select-Object ProcessName, UserName -First 5

Write-Output "[+] Fetching Recent Event Logs..."
Get-EventLog -LogName System -Newest 5 | Select-Object TimeGenerated, EntryType, Message
