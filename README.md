# AutoKali
Auto installs useful programs and scripts for recon, enumeration and exploitation for Kali that aren't included by default, as well as essential programs for any Kali user.

## Usage:
Install everything (with y/N check before proceeding):

    ./AutoKali.sh
    
Specific installations and changes:

    ./AutoKali.sh --core, -c        Install only Apt and Gem programs
    ./AutoKali.sh --git, -g         Install only Git scripts and programs
    ./AutoKali.sh --meta, -m        Perform Metasploit Exploit-DB setup
    ./AutoKali.sh --pip, -p         Install Python Pip packages and libraries
    
Usage and Help option:

    ./AutoKali.sh --help, -h

## Overview of AutoKali:
I created this script so I (and everyone) could avoid the tedium of having to work through a checklist of necessary changes/modifications needed to make a fresh install of Kali Linux more usable, with the added bonus of adding convenient and popular scripts. That said, AutoKali is very useful on non-fresh installations too, with its abundance of industry-standard programs and scripts.

Basically AutoKali:
- Installs a series of programs for Recon, Web Enum, File Analysis, Reverse Engineering, Active Directory Enum and exploitation.
- Installs useful Port, Linux, Windows, Active Directory enumeration and exploit/escalation scripts as well as scripts for Recon and Information Gathering.
- Adds languages and language support: installs GoLang, Pip, Pip3.
- Fixes common libwacom-common bug that breaks 'apt upgrade', and other minor issues.
- Installs VSCode.
- Does a general Kali system update and upgrade.

To a comprehensive list of what AutoKali installs see [InstallationList.md](https://github.com/vaarg/AutoKali/blob/main/InstallationList.md) file.

## In Future Updates:
- More essential and useful programs, scripts and libraries.
- General, yet essential instructions; for example, how to configure BurpSuite & Zap proxy.
- Other recommended programs, such as browser extensions for WebApp analysis.
- A text file with website and PDF resources will be added in this repository (and perhaps even specific guides/cheatsheets).
- Useful reverse and bind shells.
- Fine tuning.
