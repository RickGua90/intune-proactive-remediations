<#
    PROJECT: Fast Startup (Detection)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Targets the HKLM Session Manager Power registry hive.
    2. Checks the value of 'HiberbootEnabled'.
    3. Returns Exit 0 if Fast Startup is already disabled (Value 0).
    4. Returns Exit 1 if Fast Startup is active, triggering remediation.
#>

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$name = "HiberbootEnabled"

$value = Get-ItemProperty -Path $registryPath -Name $name -ErrorAction SilentlyContinue

if ($value.$name -eq 0) {
    Write-Output "COMPLIANT: Fast Startup is already disabled."
    exit 0 
} else {
    Write-Output "NON-COMPLIANT: Fast Startup is enabled. Triggering remediation."
    exit 1 
}
