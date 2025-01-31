Write-Output "[+] Gathering System Information..."
Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsArchitecture, WindowsBuildLabEx | Format-Table -AutoSize

Write-Output "[+] Listing Running Processes (Top 10)..." # Added Top 10 clarification
Get-Process | Sort-Object CPU -Descending | Select-Object ProcessName, Id, CPU -First 10 | Format-Table -AutoSize # Sorted by CPU

Write-Output "[+] Checking Disk Space Usage..."
Get-PSDrive -PSProvider FileSystem | Where-Object {$_.Root -ne "A:\" -and $_.Root -ne "C:\"} | Select-Object Name, @{Name="Used(GB)";Expression={[math]::Round($_.Used / 1GB, 2)}}, @{Name="Free(GB)";Expression={[math]::Round($_.Free / 1GB, 2)}}, @{Name="Total(GB)";Expression={[math]::Round($_.Total / 1GB, 2)}} | Format-Table -AutoSize # Added Total and filtered out A: and C: drives

Write-Output "[+] Fetching Network Configuration..."
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPv4Address, IPv6Address | Format-Table -AutoSize

Write-Output "[+] Retrieving Installed Software (Top 10)..."
Get-WmiObject -Class Win32_Product | Sort-Object Name | Select-Object Name, Version -First 10 | Format-Table -AutoSize # Sorted by name

Write-Output "[+] Checking Current Logged-In Users..."
# More robust way to get logged-in user (accounts for multiple sessions)
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object UserName | Format-Table -AutoSize

Write-Output "[+] Fetching Recent System Event Logs (Top 5)..." # Added Top 5 clarification
Get-WinEvent -LogName System -MaxEvents 5 | Sort-Object TimeCreated -Descending | Select-Object TimeCreated, Id, Message | Format-Table -AutoSize # Sorted by TimeCreated
