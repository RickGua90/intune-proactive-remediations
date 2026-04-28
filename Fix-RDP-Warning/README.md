# RDP Redirection Warning Fix

## Overview
This repository contains PowerShell scripts designed for Microsoft Intune to update the Remote Desktop Protocol (RDP) security warning dialogue. In enterprise environments, legacy warning boxes can appear untrustworthy or confusing to end users. These scripts enforce the modernised redirection warning dialogue box, providing a clearer interface while maintaining robust security standards.

## Key Features
* **Modernised UI Enforcement**: Switches the RDP connection warning to the updated Windows version for improved user clarity.
* **Registry Integrity**: Automatically detects if the necessary policy path exists and creates it if required.
* **Policy Compliance**: Ensures all managed devices adhere to a consistent connection experience, reducing helpdesk queries regarding unknown publishers.

## Deployment & Testing
Before deploying these scripts to your entire fleet, it is strongly recommended to use a dedicated Testing Group to validate the results on a small subset of devices. 

For a step by step guide on how to set this up, please refer to my documentation here: https://github.com/RickGua90/How_To/blob/7aa316a7a7313245b0006747091482029fab9251/Create_or_delete_a_group_in_Intune.pdf

## Disclaimer
**READ BEFORE USE**: These scripts are for educational purposes. I hold no responsibility for any system issues or broken functionality. Always test before deploying.
