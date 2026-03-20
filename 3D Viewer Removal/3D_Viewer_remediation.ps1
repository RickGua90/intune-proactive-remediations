<#
    PROJECT: 3D Viewer (Remediation)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Force terminates any active 3D Viewer processes.
    2. Uninstalls the application from all existing user profiles.
    3. Removes the provisioned 'master' copy from the Windows Image.
    4. Performs a deep clean of the Appx registry and uninstall keys.
    5. Wipes leftover application data from Program Files and LocalAppData.
#>

# Stop the process if it is running
Get-Process -Name "3DViewer" -ErrorAction SilentlyContinue | Stop-Process -Force

# 1. Remove from all existing user profiles
Get-AppxPackage -Name "*Microsoft3DViewer*" -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue

# 2. Remove the provisioned 'master' copy from the system image
Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*Microsoft3DViewer*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue

# 3. Deep clean registry keys for all user stores
$RegPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Applications",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach ($Path in $RegPaths) {
    Get-ChildItem -Path $Path -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "*Microsoft3DViewer*"} | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

# 4. Final wipe of leftover app folders
$FolderPaths = @(
    "$env:ProgramFiles\WindowsApps\*Microsoft3DViewer*",
    "$env:LocalAppData\Packages\*Microsoft3DViewer*"
)

foreach ($Folder in $FolderPaths) {
    Remove-Item -Path $Folder -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Output "SUCCESS: 3D Viewer has been fully removed from the system."
