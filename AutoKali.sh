#!/bin/bash

function checkInstall() {
    which $1 > /dev/null 2>&1
}

function aptInstall() {
    for APP in $@
    do
        checkInstall $APP
        if [ "$?" -eq 0 ]
        then
            echo "$APP is already installed!" 
        else
            sudo apt install $APP
        fi
    done
}

# function gitFolderPresent() {
#     ls | grep $1
# }

function gitFolderCreate() {
    # gitFolderPresent $1
    ls | grep $1 > /dev/null 2>&1
    if [ "$?" -eq 0 ]
    then
        echo "Folder $1 already exists!!"
    else
        mkdir $1
    fi
    cd $1
}

function gitInstall() {
    RESULT = $(git clone $1)
    if [ "$?" -eq 0 ]
    then
        echo $RESULT
    else
        echo "Git program from $1 is already installed!"
    fi
}

# Kali Repository Sync:
sudo apt update

# Metasploit Exploit-DB Init:
systemctl start postgresql && msfdb init

# APT Programs:
aptInstall python2 python-pip
aptInstall python3 python3-pip
aptInstall python-pip
aptInstall python3-pip
aptInstall pst-utils
aptInstall gcc-mingw-w64
aptInstall gobuster
aptInstall zaproxy
aptInstall ghidra
aptInstall ltrace
aptInstall exiftool
aptInstall Bloodhound
aptInstall crackmapexec
aptInstall sublist3r
aptInstall amass

# # VSCode:
# aptInstall software-properties-common apt-transport-https
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
# sudo apt update
# aptInstall code

## Git Programs:
cd ~ && gitFolderCreate EnumTools

# PortEnum:
gitFolderCreate PortEnum
gitInstall https://github.com/vaarg/Gatherum

# LinuxEnum:
cd ~/EnumTools && gitFolderCreate LinuxEnum
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh > linpeas.sh
gitInstall https://github.com/rebootuser/LinEnum
gitInstall https://github.com/mzet-/linux-exploit-suggester
gitInstall https://github.com/linted/linuxprivchecker
gitInstall https://github.com/diego-treitos/linux-smart-enumeration

# WinEnum:
cd ~/EnumTools && gitFolderCreate WinEnum
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
cd ~/EnumTools && gitFolderCreate ActiveDirectory
curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_386.exe > kerbrute_windows_386.exe
curl -L https://github.com/ropnop/kerbrute/releases/kerbrute_windows_amd64.exe > kerbrute_windows_amd64.exe
gitInstall https://github.com/BloodHoundAD/BloodHound
gitInstall https://github.com/GhostPack/Rubeus

# Recon & Info Gathering:
cd ~/EnumTools && gitFolderCreate Recon
gitInstall https://github.com/hmaverickadams/breach-parse
gitInstall https://github.com/tomnomnom/httprobe
gitInstall https://github.com/tomnomnom/assetfinder
gitInstall https://github.com/sensepost/gowitness
gitInstall https://github.com/Gr1mmie/sumrecon

# Kali Repository Update:
sudo apt upgrade
