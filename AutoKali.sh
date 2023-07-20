#!/bin/bash

# AutoKali v 1.0.29
# Author: https://github.com/vaarg/

# Usage:
    # ./AutoKali.sh (for all changes, y/N prompt to confirm)
    # ./AutoKali.sh --core, -c   Install only Apt and Gem programs
    # ./AutoKali.sh --git, -g    Install only Git scripts and programs
    # ./AutoKali.sh --meta, -m   Perform Metasploit Exploit-DB setup
    # ./AutoKali.sh --pip, -p    Install Python Pip packages and libraries
# Description:
    # AutoKali automatically installs useful programs and scripts for recon, enumeration and exploitation for Kali Linux 
    # that aren't included by default, as well as essential programs for any Kali user.
    # For a list of installations visit https://github.com/vaarg/AutoKali/blob/main/Resources/AutoKali_Installations.md

check=0
ARGS=$@
PROGNAME=$(basename $0)
CYAN="\e[36m"
GREEN="\e[32m"
RED="\e[31m"
ENDCOLOR="\e[0m"

function checkInstall() {
    which $1 > /dev/null 2>&1
}

function aptInstall() {
    for APP in $@
    do
        checkInstall $APP
        if [ "$?" -eq 0 ]
        then
            echo -e "${CYAN}\r\n[*] $APP is already installed!\r\n${ENDCOLOR}"
            return 1
        else
            echo -e "${GREEN}\r\n[+] Installing $APP!\r\n${ENDCOLOR}"
            sudo apt install $APP
            return 0
        fi
    done
}

function gemInstall() {
    for APP in $@
    do
        checkInstall $APP
        if [ "$?" -eq 0 ]
        then
            echo -e "${CYAN}\r\n[*] $APP is already installed!\n\r${ENDCOLOR}"
            return 1
        else
            echo -e "${GREEN}\r\n[+] Installing $APP!\n\r${ENDCOLOR}"
            sudo gem install $APP
            return 0
        fi
    done
}

function gitFolderCreate() {
    ls | grep $1 > /dev/null 2>&1
    if [ "$?" -eq 0 ]
    then
        echo -e "${CYAN}\r\n[*] Folder $1 already exists!\n\r${ENDCOLOR}"
    else
        echo -e "${GREEN}\r\n[+] Creating folder $1 in $PWD!\n\r${ENDCOLOR}"
        mkdir $1
    fi
    cd $1
}

function gitInstall() {
    RESULT=$(git clone $1)
    if [ "$?" -eq 0 ]
    then
        echo -e "${GREEN}\r\n[+] Installing Git script/program from $1!\n\r${ENDCOLOR}"
        echo $RESULT
    else
        echo -e "${CYAN}\r\n[*] Git script/program from $1 is already installed!\n\r${ENDCOLOR}"
    fi
}

function pipInstall() {
    checkInstall $1
    if [ $? -eq 0 ]
    then
        echo -e "${CYAN}\r\n[*] $1 is already installed!\n\r${ENDCOLOR}"
        return 1
    else
        echo -e "${GREEN}\r\n[+] Installing $1!\r\n${ENDCOLOR}"
        sudo apt install $2
        return 0
    fi
}

function programsCore() { ## APT/GEM Programs:
    # Core:
    aptInstall gcc-mingw-w64                    # mingw GCC
    aptInstall wine                             # Windows compatibility layer for POSIX systems
    if [ "$?" -eq 0 ]
    then
        sudo dpkg --add-architecture i386
        kaliSync
        sudo apt install wine32:i386
    else
        return 1
    fi
    aptInstall golang                           # Install Golang
    if [ "$?" -eq 0 ]
    then
        export GOROOT=/usr/lib/go
        export GOPATH=$HOME/go
        export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
        # source .bashrc
    else
        return 1
    fi
    aptInstall libwacom-common                  # Required Kali library that breaks apt upgrade if not installed
    if [ "$?" -eq 0 ]
    then
        kaliSync
    else
        return 1
    fi
    aptInstall python2
    pipInstall pip2 python-pip                  # Py2 Pip
    pipInstall pip3 python3-pip                 # Py3 Pip

    # Recon:
    aptInstall amass                            # OWASP Domain surface mapper
    aptInstall assetfinder                      # Domain/Subdomain enumerator
    aptInstall gobuster                         # Directory/Subdom enumerator

    # Web Enum & Tools:
    aptInstall sublist3r                        # Domain enumerator
    aptInstall zaproxy                          # OWASP Zap (~Burp eqv)
    aptInstall php-curl                         # PHP Tools

    # Wordlists
    aptInstall seclists                        # Seclists wordlists
    
    # Browser Exploitation:
    aptInstall beef-xss                         # Browser Exploitation Framework
    
    # Bruteforcing and Password Attacks:
    aptInstall crowbar                          # Bruteforcing Tool

    # File Analysis:
    aptInstall steghide                         # Steganography Tool
    aptInstall exiftool                         # Image Metadata Analyser
    aptInstall pst-utils                        # Outlook pst viewer & utils
    
    # File Transfer:
    aptInstall pure-ftpd                        # Secure FTP Server
    
    # Port-Forwarding:
    aptInstall rinetd                           # Port-Forwarding & Redirection Server

    # Reverse Engineering and Tracing:
    aptInstall ghidra                           # NSA Reverse Engineering Tool
    aptInstall ltrace                           # Library call tracer
    
    # Anti-Virus Evasion:
    aptInstall shellter                         # Shellcode Injection Tool and Dynamic PE Infector

    # AD/Win Tools
    aptInstall bloodhound                       # AD/Azure enumerator
    gemInstall evil-winrm                       # Windows hacking shell           

    # EDB Debugger:
    checkInstall edb
    if [ "$?" -eq 0 ]
    then
        echo -e "${GREEN}\r\n[*] EDB Debugger is already installed!\n\r${ENDCOLOR}"
    else
        aptInstall edb-debugger
    fi

    # VSCode:
    checkInstall code
    if [ "$?" -eq 0 ]
    then
        echo -e "${GREEN}\r\n[*] VSCode is already installed!\n\r${ENDCOLOR}"
    else
        aptInstall software-properties-common 
        aptInstall apt-transport-https
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
        sudo apt update
        aptInstall code
    fi
    check=1
}

function programsGit() { ## GIT Scripts & Programs:
    cd ~/Desktop && gitFolderCreate ReconAndEnumTools

    # PortEnum:
    # gitFolderCreate PortEnum
    # gitInstall https://github.com/vaarg/Gatherum

    # LinuxEnum:
    cd ~/Desktop/ReconAndEnumTools && gitFolderCreate LinuxEnum
    curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh > linpeas.sh
    gitInstall https://github.com/rebootuser/LinEnum
    gitInstall https://github.com/mzet-/linux-exploit-suggester
    gitInstall https://github.com/linted/linuxprivchecker
    gitInstall https://github.com/diego-treitos/linux-smart-enumeration

    # WinEnum:
    cd ~/Desktop/ReconAndEnumTools && gitFolderCreate WinEnum
    curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe > winPEASx64.exe
    curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx86.exe > winPEASx86.exe
    gitInstall https://github.com/PowerShellMafia/PowerSploit               # PowerUp.ps1 (WinEnum) and PowerView.ps1 (for AD)
    gitInstall https://github.com/AonCyberLabs/Windows-Exploit-Suggester    # Add Py2 dependencies
    gitInstall https://github.com/bitsadmin/wesng                           # Py3 version of WinExploitSuggester
    gitInstall https://github.com/GhostPack/Seatbelt
    gitInstall https://github.com/rasta-mouse/Watson
    gitInstall https://github.com/GhostPack/SharpUp
    gitInstall https://github.com/rasta-mouse/Sherlock
    gitInstall https://github.com/411Hall/JAWS

    # ActiveDirectory
    cd ~/Desktop/ReconAndEnumTools && gitFolderCreate ActiveDirectory
    curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_386.exe > kerbrute_windows_386.exe
    curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_amd64.exe > kerbrute_windows_amd64.exe
    curl -L https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip > mimikatz_trunk.zip
    # gitInstall https://github.com/BloodHoundAD/BloodHound
    gitInstall https://github.com/GhostPack/Rubeus

    # Recon & Info Gathering:
    cd ~/Desktop/ReconAndEnumTools && gitFolderCreate Recon
    gitInstall https://github.com/hmaverickadams/breach-parse
    gitInstall https://github.com/tomnomnom/httprobe
    # gitInstall https://github.com/tomnomnom/assetfinder
    gitInstall https://github.com/sensepost/gowitness
    gitInstall https://github.com/Gr1mmie/sumrecon
    curl -L https://raw.githubusercontent.com/TCM-Course-Resources/Practical-Ethical-Hacking-Resources/master/bash/webrecon.sh > webrecon.sh
}

function metasploitInit() { ## Metasploit Exploit-DB Init:
    sudo systemctl start postgresql && sudo msfdb init
    # sudo update-rc.d postgresql enable && sudo service metasploit start && sudo service metasploit restart
}

function pipLib() { ## PIP Packages:
    if [ $check == 1 ]
    then
        pip3 install pycryptodomex          # Python Encryption library
        pip3 install pyftplib               # Python FTP library
        pip3 install mitm6                  # Windows/AD mitm pentesting tool   
    else
        aptInstall python2 
        pipInstall pip2 python-pip                  # Py2 Pip
        pipInstall pip3 python3-pip                 # Py3 Pip
        check=1
        pipLib
    fi
}

function help() {
    echo "Usage: $PROGNAME [OPTION ...] [--meta] [-p]
AutoKali installs useful programs and scripts for recon, enumeration and exploitation.
Options:
-h, --help          Display this usage message and exit
-c, --core          Install Apt and Gem Programs
-g, --git           Install Git Programs and Scripts
-m, --meta          Perform Metasploit Exploit-DB Setup
-p, --pip           Install Python Pip Packages
For a list of installations visit https://github.com/vaarg/AutoKali/blob/main/Resources/AutoKali_Installations.md"
    exit 1
}

function kaliSync() {
    sudo apt update      ## Kali Repository Sync  
}

# Main:
function main() {
    if [[ $1 == "-h" ]] || [[ $1 == "--help" ]];
    then
        help
    elif [ $# == 0 ]
    then
        read -p "AutoKali will perform the following:
    [*] Install Apt and Gem Programs
    [*] Install Git Programs and Scripts
    [*] Perform Metasploit Exploit-DB Setup
    [*] Install Python Pip Packages
    [y/N] to continue, or lauch AutoKali with [-h/--help] to see more options: " CHOICE
        case "$CHOICE" in
            [yY]|[yY][eE][sS])
                echo -e "${GREEN}\r\n[*] Installing all programs!\n\r${ENDCOLOR}"
                kaliSync
                programsCore
                programsGit
                metasploitInit
                pipLib
                ;;
            *)
                echo -e "${RED}\r\nExiting AutoKali!\r${ENDCOLOR}"
                exit 0
                ;;
        esac   
    else
        for ARG in $@
        do
            if [[ $ARG != "-c" ]] && [[ $ARG != "--core" ]] && [[ $ARG != "-g" ]] && [[ $ARG != "--git" ]] && [[ $ARG != "-m" ]] && [[ $ARG != "--meta" ]] && [[ $ARG != "-p" ]] && [[ $ARG != "--pip" ]];
            then
                help
            fi
        done
        kaliSync
        for ARG in $@
        do
            if [[ $ARG == "-c" ]] || [[ $ARG == "--core" ]];
            then
                echo -e "${GREEN}\r\n[*] Installing Apt and Gem Programs!\n\r${ENDCOLOR}"
                programsCore
            elif [[ $ARG == "-g" ]] || [[ $ARG == "--git" ]];
            then
                echo -e "${GREEN}\r\n[*] Installing Git Programs and Scripts!\n\r${ENDCOLOR}"
                programsGit
            elif [[ $ARG == "-m" ]] || [[ $ARG == "--meta" ]];
            then
                echo -e "${GREEN}\r\n[*] Performing Metasploit Exploit-DB Setup!\n\r${ENDCOLOR}"
                metasploitInit
            elif [[ $ARG == "-p" ]] || [[ $ARG == "--pip" ]];
            then
                echo -e "${GREEN}\r\n[*] Installing Python Pip Packages!\n\r${ENDCOLOR}"
                pipLib
            fi
        done  
    fi
}

main $@
sudo apt upgrade # Kali System Upgrade

exit 0
