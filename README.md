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

## Overview of what AutoKali Is and What It Does:
I created this script so I (and everyone) could avoid the tedium of having to work through a checklist of necessary changes/modifications needed to make a fresh install of Kali Linux more usable, with the added bonus of adding convenient and popular scripts. That said, AutoKali is very useful on non-fresh installations too, with its abundance of industry-standard programs and scripts.

Basically AutoKali:
- Installs a series of programs for Recon, Web Enum, File Analysis, Reverse Engineering, Active Directory Enum and exploitation.
- Installs useful Port, Linux, Windows, Active Directory enumeration and exploit/escalation scripts as well as scripts for Recon and Information Gathering.
- Adds languages and language support: installs GoLang, Pip, Pip3.
- Fixes common libwacom-common bug that breaks 'apt upgrade', and other minor issues.
- Installs VSCode.
- Does a general Kali system update and upgrade.

## Core Installations (--core/-c):

**Kali Installations**:
| Name | Description | Category |
| --------------- | --------------- | --------------- | 
| GCC-mingw-w64 | GCC Compiler+ | Core |
| GoLang | Go Language | Core |
| libwacom-common | libwacom-common library | Core |
| PyPi2 (Pip2) | Python Package Index for Python 2.7 | Core |
| PyPi3 (Pip2) | Python Package Index for Python 3+ | Core |
| Amass | OWASP Domain Surface Mapper | Recon/WebEnum |
| Assetfinder | Domain/Subdomain enumerator | Recon/WebEnum |
| GoBuster | Directory/Subdom enumerator | Recon/WebEnum |
| Sublist3r | Domain enumerator | Recon/WebEnum |
| Zaproxy | OWASP Zap (~BurpSuite eqv) | Recon/WebEnum |
| Exiftool | Image Metadata Analyser | File Analysis |
| PST-Utils | Outlook pst Viewer & Utils | File Analysis |
| Ghidra | NSA Reverse Engineering Tool | Reverse Engineering/Tracing |
| LTrace | Library Call Tracer | Reverse Engineering/Tracing |
| BloodHound | Active Directory Enumerator/Visualiser | AD/Win Tools |
| Evil-WinRM | Windows Hacking Shell | AD/Win Tools |
| Visual Studio Code | Source Code Editor/IDE | AD/Win Tools |
| [To add...!] | [To add...!] | [To add...!] |

## Git Scripts/Programs (--git/-g):

**Linux**:
| Name | Description/Type | Source |
| --------------- | --------------- | --------------- |
| LinPEAS | Linux Privilege Escalator/Enumerator | https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS |
| LinEnum | Linux Privilege Escalator/Enumerator | https://github.com/rebootuser/LinEnum |
| Linux Exploit Suggester | Linux Exploit Suggester (CVEs/Kernel) | https://github.com/mzet-/linux-exploit-suggester |
| LinuxPrivChecker | Linux Privilege Escalator/Enumerator | https://github.com/linted/linuxprivchecker |
| Linux Smart Enumeration | Linux Privilege Escalator/Enumerator | https://github.com/diego-treitos/linux-smart-enumeration |

**Windows**:
| Name | Description/Type | Source |
| --------------- | --------------- | --------------- |
| WinPEAS | Windows Privilege Escalator/Enumerator (x64/x86) | https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS |
| PowerUp | Windows Privilege Escalator/Enumerator | https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc |
| Windows Exploit Suggester | Windows Exploit Suggester -Py2 (MSs) | https://github.com/AonCyberLabs/Windows-Exploit-Suggester |
| Windows Exploit Suggester - Next Generation | Windows Exploit Suggester -Py3 (MSs) | https://github.com/bitsadmin/wesng |
| Seatbelt | Windows Privilege Escalator/Enumerator ("Safety Checks") | https://github.com/GhostPack/Seatbelt |
| Watson | Windows Exploit Suggester (CVEs) | https://github.com/rasta-mouse/Watson |
| SharpUp | Windows Privilege Escalator/Enumerator (~PowerUp) | https://github.com/GhostPack/SharpUp |
| Sherlock | Windows Exploit Suggester (CVEs/MSs ~ Watson) | https://github.com/rasta-mouse/Sherlock |
| JAWS(.ps1) | Windows Privilege Escalator/Enumerator | https://github.com/411Hall/JAWS |

**Active Directory/Azure**:
| Name | Description/Type | Source |
| --------------- | --------------- | --------------- |
| Kerbrute | Active Directory Bruteforcer | https://github.com/ropnop/kerbrute |
| Mimikatz | AD Password, PIN, Kerberos ticket extractor, Pass the Hash/Ticket, Golden Tickets | https://github.com/gentilkiwi/mimikatz |
| Rubeus | Kerberos Exploitation | https://github.com/GhostPack/Rubeus |

**Recon, Information Gathering & Network Enumeration**:
| Name | Description/Type | Source |
| --------------- | --------------- | --------------- |
| Gatherum | Nmap Based Port Enumerator | https://github.com/vaarg/Gatherum |
| Breach Parse | Breach Passwords Parser - for Data Breaches | https://github.com/hmaverickadams/breach-parse |
| HTTProbe | Takes Domain List, probes for HTTP/HTTPs Servers | https://github.com/tomnomnom/httprobe |
| GoWitness | Chromium Web Screenshotter | https://github.com/sensepost/gowitness |
| SumRecon | General Site Enumerator | https://github.com/Gr1mmie/sumrecon |
| WebRecon | General Site Enumerator | https://github.com/TCM-Course-Resources/Practical-Ethical-Hacking-Resources/tree/master/bash |

## In Future Updates:
- A breakdown of *what is actually installed* by this script and links to source GitHubs.
- More essential and useful programs, scripts and libraries.
- General, yet essential instructions; for example, how to configure BurpSuite & Zap proxy.
- Other recommended programs, such as browser extensions for WebApp analysis.
- A text file with website and PDF resources will be added in this repository (and perhaps even specific guides/cheatsheets).
- Useful reverse and bind shells.
- Fine tuning.
