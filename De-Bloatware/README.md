# Intune Proactive Remediations

## Overview
This repository contains PowerShell scripts for Intune to automate the removal of enterprise bloatware. The goal is to harden Windows endpoints and reduce the attack surface by removing unneeded OEM software and consumer applications.

## Key Features
* **Deep Clean**: Targets 'Staged' system packages to ensure apps do not return.
* **Broad Coverage**: Targets HP, Dell, Lenovo, ASUS, and McAfee.
* **OS Hardening**: Removes Xbox components and the Microsoft Store.

## Deployment & Testing
Before deploying these scripts to your entire fleet, it is strongly recommended to use a dedicated Testing Group to validate the results on a small subset of devices. 

For a step-by-step guide on how to set this up, please refer to my documentation here:
https://github.com/RickGua90/How_To/blob/7aa316a7a7313245b0006747091482029fab9251/Create_or_delete_a_group_in_Intune.pdf

## Disclaimer
**READ BEFORE USE**: These scripts are for educational purposes. I hold no responsibility for any system issues or broken functionality. Always test before deploying.
