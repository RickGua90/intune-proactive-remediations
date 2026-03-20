<#
    PROJECT: Fast Startup (Remediation)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Attempts to modify the 'HiberbootEnabled' registry key to 0.
    2. Disables the 'Fast Startup' feature to ensure a full kernel reset on shutdown.
    3. Implements error handling to catch permission or path issues.
    4. Outputs the result for Intune/Kandji logging purposes.
#>

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$name = "HiberbootEnabled"
$value = 0

try {
    Set-ItemProperty -Path $registryPath -Name $name -Value $value -ErrorAction Stop
    Write-Output "SUCCESS: Fast Startup has been disabled."
    exit 0
} catch {
    Write-Error "FAILURE: Failed to disable Fast Startup: $($_.Exception.Message)"
    exit 1
}
