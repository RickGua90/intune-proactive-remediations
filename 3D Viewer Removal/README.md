# Intune Proactive Remediations - 3D Viewer Removal
## Overview
This repository contains PowerShell scripts for Intune designed to automate the complete removal of the Microsoft 3D Viewer application. By removing non-essential consumer software, we improve the security posture and streamline the user experience for Everton FC workstations.

## Key Features
* **Multi-Layered Removal**: Targets active user packages, provisioned image packages, and registry keys.
* **Aggressive Clean**: Unlike standard uninstalls, this script wipes leftover data in Program Files and AppData to ensure a clean state.
* **Process Management**: Automatically terminates active instances of the app before attempting removal to prevent file-lock errors.

## Deployment & Testing
Before deploying these scripts to your entire fleet, it is strongly recommended to use a dedicated Testing Group to validate the results on a small subset of devices.

For a step-by-step guide on how to set this up, please refer to my documentation here: https://github.com/RickGua90/How_To/blob/7aa316a7a7313245b0006747091482029fab9251/Create_or_delete_a_group_in_Intune.pdf

## Disclaimer
**READ BEFORE USE**: These scripts are for educational purposes. I hold no responsibility for any system issues or broken functionality. Always test before deploying.
