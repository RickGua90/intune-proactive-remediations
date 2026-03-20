<#
    PROJECT: System Uptime Auditor (Remediation)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Verifies non-compliance status before initiating user interaction.
    2. Triggers a system-modal UI prompt via Microsoft.VisualBasic assembly.
    3. Captures user-defined timeframes for scheduled restarts.
    4. Executes a native Windows shutdown command with a custom countdown.
    5. Provides a secondary reminder if the user opts to defer.
#>

Add-Type -AssemblyName Microsoft.VisualBasic

$bootTime = Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty LastBootUpTime
$uptime = New-TimeSpan -Start $bootTime -End (Get-Date)

# Set to 168 = 7 days
if ($uptime.TotalHours -gt 168) {
    $msgTitle = "IT Security Maintenance"
    $msgText = "Your laptop has been on for over 7 days. Would you like to schedule a restart in 15 minutes?"
    
    # 4 = Yes/No buttons
    $choice = [Microsoft.VisualBasic.Interaction]::MsgBox($msgText, 4 + 64 + 4096, $msgTitle)

    if ($choice -eq 6) {
        # If 'Yes'
        shutdown /r /t 900 /c "Restart scheduled in 15 minutes. Please save your work."
    } else {
        # Abort any pending shutdown and show the 'No' reminder
        shutdown /a 2>$null
        
        $reminderTitle = "IT Security Maintenance"
        $reminderText = "Please, restart your device when you can"
        [Microsoft.VisualBasic.Interaction]::MsgBox($reminderText, 0 + 64 + 4096, $reminderTitle)
    }
}
