# Intune Proactive Remediations - Fast Startup Auditor
## Overview
This repository contains PowerShell scripts for Intune designed to disable Windows "Fast Startup". In enterprise environments, Fast Startup can prevent systems from fully resetting during a shutdown, leading to artificial uptime inflation and pending security updates not being applied correctly.

## Key Features
* **Registry Level Detection**: Accurately identifies the state of the HiberbootEnabled key.
* **Kernel Reset Enforcement**: Ensures that a shutdown performs a complete power cycle of the OS kernel.
* **Improved Reliability**: Solves the common issue where "Shutting down" does not clear system errors or reset the uptime clock.

## Deployment & Testing
Before deploying these scripts to your entire fleet, it is strongly recommended to use a dedicated Testing Group to validate the results on a small subset of devices.

For a step by step guide on how to set this up, please refer to my documentation here: https://github.com/RickGua90/How_To/blob/7aa316a7a7313245b0006747091482029fab9251/Create_or_delete_a_group_in_Intune.pdf

## Disclaimer
**READ BEFORE USE**: These scripts are for educational purposes. I hold no responsibility for any system issues or broken functionality. Always test before deploying.
