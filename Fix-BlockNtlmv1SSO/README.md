# BlockNtlmv1SSO Authentication Fix

## Overview

This repository contains PowerShell scripts designed for Microsoft Intune Proactive Remediations to manage the `BlockNtlmv1SSO` registry value. In enterprise environments, upcoming changes to NTLMv1 restrictions can disrupt legacy authentication protocols like WPA2-Enterprise PEAP. These scripts ensure the registry is correctly configured to maintain seamless authentication functionality.

## Key Features

* **Automated Compliance:** Continuously evaluates endpoints for correct registry state and applies remediation when required.
* **Registry Integrity:** Automatically detects if the necessary LSA policy path exists, creating it if needed before setting values.
* **Proactive Management:** Keeps fleet authentication configurations consistent to minimize user sign-in failures and helpdesk tickets.

## Deployment & Testing

Before deploying these scripts to your entire fleet, it is strongly recommended to use a dedicated Testing Group to validate the results on a small subset of devices.

For a step by step guide on how to set this up, please refer to my documentation here:
[Intune Proactive Remediations Setup Guide](https://github.com/RickGua90)

## Disclaimer

READ BEFORE USE: These scripts are for educational purposes. I hold no responsibility for any system issues or broken functionality. Always test before deploying.
