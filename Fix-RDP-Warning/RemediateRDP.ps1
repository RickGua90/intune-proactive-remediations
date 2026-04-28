<#
    PROJECT: RDP Redirection Warning Fix (Remediation)
    AUTHOR: Rick

    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.
    
    LOGIC:
    1. Verifies if the Terminal Services Client policy path exists.
    2. Creates the registry path if it is missing from the system.
    3. Sets 'RedirectionWarningDialogVersion' to 1 to enable the modern UI.
#>

$path = "HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services\Client"
$name = "RedirectionWarningDialogVersion"
$value = 1

if (-not (Test-Path $path)) {
    New-Item -Path $path -Force | Out-Null
}

New-ItemProperty -Path $path -Name $name -Value $value -PropertyType DWORD -Force | Out-Null

Write-Output "Remediation: Folder and Key created successfully"
