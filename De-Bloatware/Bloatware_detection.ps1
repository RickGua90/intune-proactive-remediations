<#
    PROJECT: Bloatware Removal (Detection)
    AUTHOR: Rick
    
    DISCLAIMER: 
    This script is for testing and educational purposes only. 
    I hold no responsibility for any system issues or broken 
    functionality. Use at your own risk.

    LOGIC:
    1. Detects Hardware Vendor via WMI with a fallback for generic BIOS.
    2. Loads exhaustive manufacturer-specific hit lists (HP, Dell, Lenovo, ASUS).
    3. Merges with McAfee and Microsoft Consumer bloatware.
    4. Scans Provisioned (Image) and Active User packages.
    5. Returns Exit 1 if any bloatware is actionable.
#>

# --- 1. IDENTIFY HARDWARE ---
$Manufacturer = (Get-WmiObject -Class Win32_ComputerSystem).Manufacturer
if ([string]::IsNullOrWhiteSpace($Manufacturer)) { $Manufacturer = "Unknown Vendor" }

$Targets = @()

# --- 2. DEFINE THE HIT LISTS ---

$HPFullList = @(
    "HP Connection Optimizer", "HP Documentation", "HP Notifications", "HP Security Update Service",
    "HP Support Assistant", "HP Support Solutions Framework", "HP Sure Recover", "HP Sure Run Module",
    "HP System Default Settings", "HP Update", "HP Wolf Security", "HP Wolf Security - Console",
    "HP Wolf Security Application Support for Chrome", "HP Wolf Security Application Support for Sure Sense",
    "HP Client Security Manager", "HP Wolf Security Application Support for Windows",
    "HP Wolf Security Application Support for Chrome 122.0.6261.139", "HP Insights", "HP Insights Analytics",
    "HP Insights Analytics Service", "HP Insights Analytics - Dependencies", "HP Performance Advisor",
    "HP Presence Video", "HP Connect Optimizer", "AD2F1837.HPJumpStarts",
    "AD2F1837.HPPCHardwareDiagnosticsWindows", "AD2F1837.HPPowerManager", "AD2F1837.HPPrivacySettings",
    "AD2F1837.HPSupportAssistant", "AD2F1837.myHP", "AD2F1837.HPQuickDrop", "AD2F1837.HPSystemInformation"
)

$DellFullList = @(
    "Dell AppCore", "Dell Command | Update", "Dell Command | Update for Windows 10", 
    "Dell Command | Update for Windows Universal", "Dell Connected Service Delivery", 
    "Dell Connected Service Delivery SubAgent", "Dell Core Services", "Dell Digital Delivery Services", 
    "Dell Display Manager", "Dell Display Manager 2.1", "Dell Optimizer", "Dell Optimizer Core", 
    "Dell Optimizer Service", "Dell OptimizerUI", "Dell Pair", "Dell Peripheral Manager",
    "Dell Power Manager Service", "Dell SupportAssist", "Dell SupportAssist OS Recovery Plugin for Dell Update",
    "Dell SupportAssist Remediation", "Dell Trusted Device", "Dell Trusted Device Agent",
    "Dell Update for Windows Universal", "Dell.Digital.Delivery-64Bit", "Dell Power Manager",
    "Dell SupportAssist OS Recovery", "Dell Command | Power Manager", "Dell Digital Delivery Service",
    "Dell Digital Delivery", "Dell SupportAssistAgent", "Dell Update - SupportAssist Update Plugin",
    "Dell Display Manager 2.0", "Dell Display Manager 2.2", "MyDell", "MyDell Application Management", 
    "MyDell Components Installer", "MyDell Customer Connect", "DellInc.DellSupportAssistforPCs",
    "DellInc.DellDigitalDelivery", "DellInc.PartnerPromo", "DellInc.DellOptimizer", "DellInc.DellCommandUpdate",
    "DellInc.DellPowerManager", "SupportAssist Recovery Assistant"
)

$LenovoFullList = @(
    "AI Meeting Manager Service", "AI Meeting Manager", "Lenovo Now", "Lenovo Quick Clean", 
    "Lenovo Service Bridge", "Lenovo Smart Appearance Components", "Lenovo Smart Meeting Components", 
    "Lenovo Vantage", "Lenovo Vantage Service", "Lenovo Welcome", "Lenovo AI Now",
    "Lenovo Subscription Marketplace", "Lenovo User Guide", "E046963F.LenovoCompanion",
    "E046963F.LenovoSettings", "E046963F.AIMeetingManager", "E0469640.SmartAppearance",
    "E0469640.LenovoUtility", "E0469640.LenovoSmartCommunication", "E046963F.LenovoSettingsforEnterprise"
)

$AsusFullList = @(
    "ASUS AI Recovery", "ASUS App Service", "ASUS Framework Service", "ASUS Giftbox", 
    "ASUS Live Update", "ASUS Optimization", "ASUS Software Manager", 
    "ASUS Software Manager Agent", "MyASUS"
)

$McAfeeFullList = @(
    "McAfee", "McAfee LiveSafe", "McAfee LiveSafe - Internet Security", 
    "McAfee WebAdvisor", "WebAdvisor by McAfee", "5A894077.McAfeeSecurity", 
    "McAfeeWPSSparsePackage"
)

$MicrosoftFullList = @(
    "Microsoft.MicrosoftSolitaireCollection", "Microsoft.People", "Microsoft.MixedReality.Portal", 
    "Microsoft.Xbox.TCUI", "Microsoft.XboxApp", "Microsoft.XboxGameOverlay", "Microsoft.XboxGamingOverlay", 
    "Microsoft.XboxIdentityProvider", "Microsoft.XboxSpeechToTextOverlay", "Microsoft.ZuneMusic", 
    "Microsoft.ZuneVideo", "Microsoft.YourPhone", "Microsoft.GetHelp", "Microsoft.Getstarted",
    "Microsoft.Messaging", "Microsoft.Microsoft3DViewer", "Microsoft.MicrosoftJournal",
    "Microsoft.News", "Microsoft.Office.Sway", "Microsoft.OneConnect", "Microsoft.PowerAutomateDesktop", 
    "Microsoft.PowerAutomateDesktopCopilotPlugin", "Microsoft.Print3D", "Microsoft.WindowsFeedbackHub", 
    "Microsoft.Edge.GameAssist", "MicrosoftCorporationII.MicrosoftFamily", "MicrosoftCorporationII.QuickAssist", 
    "Disney.37853FC22B2CE", "king.com.CandyCrushSaga", "king.com.CandyCrushSodaSaga", 
    "king.com.BubbleWitch3Saga", "A278AB0D.DisneyMagicKingdoms", "A278AB0D.MarchofEmpires", 
    "D5EA27B7.Duolingo-LearnLanguagesforFree", "WindowsStore"
)

# --- 3. HARDWARE SELECTION ---
switch -Wildcard ($Manufacturer) {
    "*HP*"     { $Targets += $HPFullList }
    "*Dell*"   { $Targets += $DellFullList }
    "*Lenovo*" { $Targets += $LenovoFullList }
    "*ASUS*"   { $Targets += $AsusFullList }
}

# Include consumer targets
$Targets += $McAfeeFullList
$Targets += $MicrosoftFullList

# --- 4. SCANNING ---
try {
    $Found = @()
    $AllProvisioned = Get-AppxProvisionedPackage -Online
    $CurrentUserPackages = Get-AppxPackage

    foreach ($App in $Targets) {
        $IsProvisioned = $AllProvisioned | Where-Object { $_.DisplayName -match $App -or $_.PackageName -match $App }
        $IsLocal = $CurrentUserPackages | Where-Object { $_.Name -match $App }

        if ($IsProvisioned -or $IsLocal) {
            $Found += $App
        }
    }

    if ($Found.Count -gt 0) {
        $CleanList = $Found | Select-Object -Unique
        Write-Output "Detected on ${Manufacturer}: $($CleanList -join ', ')"
        exit 1 # Trigger Remediation
    }

    Write-Output "Compliant: ${Manufacturer} is clean of targeted bloatware."
    exit 0
}
catch { 
    Write-Error "An error occurred during detection."
    exit 1 
}
