<#
    PROJECT: BlockNtlmv1SSO Authentication Fix (Remediation)
    AUTHOR: Rick

    DISCLAIMER:
    This script is for testing and educational purposes only.
    I hold no responsibility for any system issues or broken
    functionality. Use at your own risk.

    LOGIC:
    1. Verifies if the LSA policy registry path exists.
    2. Creates the registry path if it is missing from the system.
    3. Sets 'BlockNtlmv1SSO' to 0 to ensure proper authentication behavior.
#>

$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"
$Name = "BlockNtlmv1SSO"
$Value = 0

if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
}

New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
Write-Output "Remediation: Folder and Key created successfully"
