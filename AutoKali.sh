#!/bin/bash

# AutoKali v 1.0.4

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
            echo -e "${CYAN}\r\n[+] $APP is already installed!\r\n${ENDCOLOR}"
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
        echo -e "${GREEN}\r\n[*] Folder $1 already exists!!\n\r${ENDCOLOR}"
    else
        mkdir $1
    fi
    cd $1
}

function gitInstall() {
    RESULT=$(git clone $1)
    if [ "$?" -eq 0 ]
    then
        echo $RESULT
    else
        echo -e "${GREEN}\r\n[*] Git program from $1 is already installed!\n\r${ENDCOLOR}"
    fi
}

function programsAptGem() { ## APT/GEM Programs:
    # Core:
    aptInstall gcc-mingw-w64                    # mingw GCC
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
    aptInstall python-pip                       # Py2 Pip
    aptInstall python3-pip                      # Py3 Pip

    # Recon:
    aptInstall amass                            # OWASP Domain surface mapper
    aptInstall gobuster                         # Directory/Subdom enumerator

    # Web Enum:
    aptInstall sublist3r                        # Domain enumerator
    aptInstall zaproxy                          # OWASP Zap (~Burp eqv)

    # Data Analysis:
    aptInstall exiftool                         # Image Metadata Analyser
    aptInstall pst-utils                        # Outlook pst viewer & utils

    # Reverse Engineering and Tracing:
    aptInstall ghidra                           # NSA Reverse Engineering Tool
    aptInstall ltrace                           # Library call tracer

    # AD/Win Tools
    aptInstall bloodhound                       # AD/Azure enumerator
    gemInstall evil-winrm                       # Windows hacking shell              

    # VSCode:
    checkInstall code
    if [ "$?" -eq 0 ]
    then
        echo -e "${GREEN}\r\n[*] VSCode is already installed!\n\r${ENDCOLOR}"
    else
        aptInstall software-properties-common apt-transport-https
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
        sudo apt update
        aptInstall code
    fi
    check=1
}

function programsGit() { ## GIT Programs:
    cd ~/Desktop && gitFolderCreate ReconAndEnumTools

    # PortEnum:
    gitFolderCreate PortEnum
    gitInstall https://github.com/vaarg/Gatherum

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
    gitInstall https://github.com/PowerShellMafia/PowerSploit #PowerUp.ps1 (WinEnum) and PowerView.ps1 (for AD)
    gitInstall https://github.com/AonCyberLabs/Windows-Exploit-Suggester # Add Py2 dependencies
    gitInstall https://github.com/bitsadmin/wesng # Py3 version of WinExploitSuggester
    gitInstall https://github.com/GhostPack/Seatbelt
    gitInstall https://github.com/rasta-mouse/Watson
    gitInstall https://github.com/GhostPack/SharpUp
    gitInstall https://github.com/rasta-mouse/Sherlock
    gitInstall https://github.com/411Hall/JAWS

    # ActiveDirectory
    cd ~/Desktop/ReconAndEnumTools && gitFolderCreate ActiveDirectory
    curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_386.exe > kerbrute_windows_386.exe
    curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_amd64.exe > kerbrute_windows_amd64.exe
    # gitInstall https://github.com/BloodHoundAD/BloodHound
    gitInstall https://github.com/GhostPack/Rubeus

    # Recon & Info Gathering:
    cd ~/Desktop/ReconAndEnumTools && gitFolderCreate Recon
    gitInstall https://github.com/hmaverickadams/breach-parse
    gitInstall https://github.com/tomnomnom/httprobe
    gitInstall https://github.com/tomnomnom/assetfinder # Sudo apt install assetfinder?
    gitInstall https://github.com/sensepost/gowitness
    gitInstall https://github.com/Gr1mmie/sumrecon
    curl -L https://raw.githubusercontent.com/TCM-Course-Resources/Practical-Ethical-Hacking-Resources/master/bash/webrecon.sh > webrecon.sh
}

function metasploitInit() { ## Metasploit Exploit-DB Init:
    sudo systemctl start postgresql && sudo msfdb init
    sudo update-rc.d postgresql enable && sudo service metasploit start && sudo service metasploit restart
}

function pipInstall() { ## PIP Packages:
    if [ $check == 1 ]
    then
        pip3 install pycryptodomex          # Python Encryption library
        pip3 install pyftplib               # Python FTP library
    else
        aptInstall python2 
        aptInstall python-pip               # Py2 PIP
        aptInstall python3-pip              # Py3 PIP
        check=1
        pipInstall
    fi
}

function help() {
    echo "Usage: $PROGNAME [OPTION ...] [--meta] [-p]
AutoKali installs useful programs and scripts for recon, enumeration and exploitation.
Options:
-h, --help          Display this usage message and exit
-a, --apt           Install Apt and Gem Programs
-g, --git           Install Git Programs and Scripts
-m, --meta          Perform Metasploit Exploit-DB Setup
-p, --pip          Install Python Pip Packages"
    exit 1
}

function kaliSync() {
    ## Kali Repository Sync:
    sudo apt update    
}

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
[y/N] to continue, or lauch AutoKali with [-h/--help] to see more options: " choice
        if [[ $choice == "y" ]] || [[ $choice == "Y" ]];
        then
            echo -e "${GREEN}\r\n[*] Installing all programs!\n\r${ENDCOLOR}"
            kaliSync
            programsAptGem
            programsGit
            metasploitInit
            pipInstall
        else
            echo -e "${RED}\r\nExiting AutoKali\n\r${ENDCOLOR}"
            exit 0
        fi
    else
        for ARG in $@
        do
            if [[ $ARG != "-a" ]] && [[ $ARG != "--apt" ]] && [[ $ARG != "-g" ]] && [[ $ARG != "--git" ]] && [[ $ARG != "-m" ]] && [[ $ARG != "--meta" ]] && [[ $ARG != "-p" ]] && [[ $ARG != "--pip" ]];
            then
                help
            fi
        done
        kaliSync
        for ARG in $@
        do
            if [[ $ARG == "-a" ]] || [[ $ARG == "--apt" ]];
            then
                echo -e "${GREEN}\r\n[*] Installing Apt and Gem Programs!\n\r${ENDCOLOR}"
                programsAptGem
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
                pipInstall
            fi
        done  
    fi
}

main
sudo apt upgrade # Kali System Upgrade

exit 0
