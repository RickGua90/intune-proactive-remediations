<#
    PROJECT: RDP Redirection Warning Fix (Detection)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Targets the Terminal Services Client policy registry hive.
    2. Checks for the existence of 'RedirectionWarningDialogVersion'.
    3. Returns Exit 0 if the modern dialogue is already enabled (Value 1).
    4. Returns Exit 1 if the key is missing or incorrect, triggering remediation.
#>

$path = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services\Client"
$name = "RedirectionWarningDialogVersion"
$value = 1

if (Test-Path $path) {
    $current = Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue
    if ($current -and $current.$name -eq $value) {
        Write-Output "Compliant: Key exists and value is 1"
        exit 0
    } else {
        Write-Output "Non-Compliant: Key missing or incorrect"
        exit 1
    }
} else {
    Write-Output "Non-Compliant: Folder path does not exist"
    exit 1
}
