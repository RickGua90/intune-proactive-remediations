<#
    PROJECT: BlockNtlmv1SSO Authentication Fix (Detection)
    AUTHOR: Rick

    DISCLAIMER:
    This script is for testing and educational purposes only.
    I hold no responsibility for any system issues or broken
    functionality. Use at your own risk.

    LOGIC:
    1. Targets the Local Security Authority (LSA) policy registry hive.
    2. Checks for the existence of 'BlockNtlmv1SSO'.
    3. Returns Exit 0 if the value is already set correctly (Value 0).
    4. Returns Exit 1 if the key is missing or incorrect, triggering remediation.
#>

$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"
$Name = "BlockNtlmv1SSO"
$Value = 0

if (Test-Path $Path) {
    $Current = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue
    if ($Current -and $Current.$Name -eq $Value) {
        Write-Output "Compliant: Key exists and value is $Value"
        exit 0
    } else {
        Write-Output "Non-Compliant: Key missing or incorrect"
        exit 1
    }
} else {
    Write-Output "Non-Compliant: Folder path does not exist"
    exit 1
}
