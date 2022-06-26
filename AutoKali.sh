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

# sudo apt update
# systemctl start postgresql && msfdb init

# aptInstall python2 python-pip
# aptInstall python3 python3-pip
# aptInstall python-pip
# aptInstall python3-pip
# aptInstall pst-utils
# aptInstall gcc-mingw-w64
# aptInstall gobuster
# aptInstall zaproxy
# aptInstall ghidra
# aptInstall ltrace
# aptInstall exiftool
# aptInstall Bloodhound

# # VSCode:
# aptInstall software-properties-common apt-transport-https
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
# sudo apt update
# aptInstall code

# Git Programs:
cd ~ && gitFolderCreate EnumTools

# PortEnum:
gitFolderCreate PortEnum
gitInstall https://github.com/vaarg/Gatherum

# LinuxEnum:
cd ~/EnumTools && gitFolderCreate LinuxEnum
# Add LinPeas!!
gitInstall https://github.com/rebootuser/LinEnum
gitInstall https://github.com/mzet-/linux-exploit-suggester
gitInstall https://github.com/linted/linuxprivchecker
gitInstall https://github.com/diego-treitos/linux-smart-enumeration

# WinEnum:
cd ~/EnumTools && gitFolderCreate WinEnum
# Add WinPeas!! https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS
# Add PowerUp! https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc
gitInstall https://github.com/AonCyberLabs/Windows-Exploit-Suggester # Add Py2 dependencies
gitInstall https://github.com/bitsadmin/wesng
gitInstall https://github.com/GhostPack/Seatbelt
gitInstall https://github.com/rasta-mouse/Watson
gitInstall https://github.com/GhostPack/SharpUp
gitInstall https://github.com/rasta-mouse/Sherlock
gitInstall https://github.com/411Hall/JAWS

# ActiveDirectory

# To Add

# # sudo apt upgrade
