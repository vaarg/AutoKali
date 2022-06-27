# AutoKali
Auto installs useful programs and scripts for recon, enumeration and exploitation for Kali that aren't included by default, as well as essential programs for any Kali user.

## Usage:
Install everything (with y/N check before proceeding):

    ./AutoKali.sh
    
Specific installations and changes:

    ./AutoKali.sh --apt         (or [-a])    Install only Apt and Gem programs
    ./AutoKali.sh --git         (or [-g])    Install only Git scripts and programs
    ./AutoKali.sh --meta        (or [-m])    Perform Metasploit Exploit-DB setup
    ./AutoKali.sh --pip         (or [-p])    Install Python Pip packages and libraries
    
Usage and Help option:

    ./AutoKali.sh --help        (or [-h])
    
## In Future Updates:
- A breakdown of *what is actually* installed by this script and links to source GitHubs.
- More essential and useful programs, scripts and libraries.
- General, yet essential instructions; for example, how to configure BurpSuite & Zap proxy.
- Other recommended programs, such as browser extensions for WebApp analysis.
- A text file with website and PDF resources will be added in this repository (and perhaps even specific guides/cheatsheets).
- Useful reverse and bind shells.
