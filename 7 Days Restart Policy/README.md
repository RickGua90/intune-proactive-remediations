# Intune Proactive Remediations - Uptime Auditor

## Overview
This repository contains PowerShell scripts for Intune to automate system uptime monitoring and user led restarts. The goal is to ensure that Windows endpoints remain compliant with security patching requirements while providing a smooth experience for the end user.

## Key Features
* **Automated Compliance**: Detects if a machine has reached the 168 hour (7 day) threshold.

* **User Empowered Scheduling**: Users can choose 'Yes' for a 15 minute window or 'No' to allow them to finish meetings or save ongoing work before manually restarting it.

* **Non-Disruptive Approach**: Specifically designed to avoid interrupting active calls or critical tasks by giving the user full control over the reboot timing.

## Deployment & Testing
Before deploying these scripts to your entire fleet, it is strongly recommended to use a dedicated Testing Group to validate the results on a small subset of devices.

For a step by step guide on how to set this up, please refer to my documentation here: https://github.com/RickGua90/How_To/blob/7aa316a7a7313245b0006747091482029fab9251/Create_or_delete_a_group_in_Intune.pdf

## Disclaimer
**READ BEFORE USE**: These scripts are for educational purposes. I hold no responsibility for any system issues or broken functionality. Always test before deploying.
