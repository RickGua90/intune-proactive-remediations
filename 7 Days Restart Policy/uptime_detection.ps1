<#
    PROJECT: System Uptime Auditor (Detection)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Queries the CIM Win32_OperatingSystem instance for LastBootUpTime.
    2. Calculates total system uptime by comparing boot time to current date.
    3. Evaluates against a 168-hour (7-day) compliance threshold.
    4. Returns Exit 1 if remediation is required, or Exit 0 if compliant.
#>

$bootTime = Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime
$uptime = New-TimeSpan -Start $bootTime -End (Get-Date)

if ($uptime.TotalHours -gt 168) {
    Write-Output "Device has been on for more than 7 Days. Remediation required."
    exit 1
} else {
    Write-Output "Uptime is under 7 Days."
    exit 0
}
