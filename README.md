# AutoKali
Auto installs useful programs and scripts for recon, enumeration and exploitation.

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
