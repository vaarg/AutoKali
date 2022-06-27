#!/bin/bash

GREEN="\e[32m"
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
            echo -e "${GREEN}\r[+] $APP is already installed!\r${ENDCOLOR}" 
        else
            sudo apt install $APP
        fi
    done
}

function gitFolderCreate() {
    ls | grep $1 > /dev/null 2>&1
    if [ "$?" -eq 0 ]
    then
        echo -e "${GREEN}\rFolder $1 already exists!!\r${ENDCOLOR}"
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
        echo -e "${GREEN}\rGit program from $1 is already installed!\r${ENDCOLOR}"
    fi
}

## Kali Repository Sync:
sudo apt update

## Metasploit Exploit-DB Init:
systemctl start postgresql && msfdb init

## APT Programs:
# Core:
aptInstall python2 python-pip               # Py2 PIP
aptInstall python3 python3-pip              # Py3 PIP
aptInstall gcc-mingw-w64                    # mingw GCC
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
# AD Tools
aptInstall Bloodhound                       # AD/Azure enumerator
aptInstall crackmapexec                     # AD/Windows exploiter
# VSCode:
aptInstall software-properties-common apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
aptInstall code

## GIT Programs:
cd ~ && gitFolderCreate Recon&EnumTools

# PortEnum:
gitFolderCreate PortEnum
gitInstall https://github.com/vaarg/Gatherum

# LinuxEnum:
cd ~/Recon&EnumTools && gitFolderCreate LinuxEnum
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh > linpeas.sh
gitInstall https://github.com/rebootuser/LinEnum
gitInstall https://github.com/mzet-/linux-exploit-suggester
gitInstall https://github.com/linted/linuxprivchecker
gitInstall https://github.com/diego-treitos/linux-smart-enumeration

# WinEnum:
cd ~/Recon&EnumTools && gitFolderCreate WinEnum
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
cd ~/Recon&EnumTools && gitFolderCreate ActiveDirectory
curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_386.exe > kerbrute_windows_386.exe
curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_amd64.exe > kerbrute_windows_amd64.exe
gitInstall https://github.com/BloodHoundAD/BloodHound
gitInstall https://github.com/GhostPack/Rubeus

# Recon & Info Gathering:
cd ~/Recon&EnumTools && gitFolderCreate Recon
gitInstall https://github.com/hmaverickadams/breach-parse
gitInstall https://github.com/tomnomnom/httprobe
gitInstall https://github.com/tomnomnom/assetfinder
gitInstall https://github.com/sensepost/gowitness
gitInstall https://github.com/Gr1mmie/sumrecon
curl -L https://raw.githubusercontent.com/TCM-Course-Resources/Practical-Ethical-Hacking-Resources/master/bash/webrecon.sh > webrecon.sh

# PIP Packages:
pip install pycryptodomex

# Kali Repository Update:
sudo apt upgrade
