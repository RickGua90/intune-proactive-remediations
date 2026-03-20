<#
    PROJECT: 3D Viewer (Detection)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Scans active user profiles for the Microsoft 3D Viewer Appx package.
    2. Checks provisioned (image-level) packages to prevent re-installation.
    3. Searches the AppxAllUserStore registry for leftover metadata.
    4. Returns Exit 1 if any traces are found, triggering remediation.
#>

$AppName = "*Microsoft3DViewer*"
$App = Get-AppxPackage -Name $AppName -AllUsers
$Provisioned = Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like $AppName}
$RegKey = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications\*Microsoft3DViewer*"

if ($App -or $Provisioned -or $RegKey) {
    Write-Output "NON-COMPLIANT: Traces of 3D Viewer detected."
    exit 1
} else {
    Write-Output "COMPLIANT: 3D Viewer is not present."
    exit 0
}
