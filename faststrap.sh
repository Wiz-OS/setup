#!/bin/sh
# =============================================================================
#  __      __________   ______
# /  \    /  \_____  \ /  __  \
# \   \/\/   //  ____/ >      <
#  \        //       \/   --   \
#   \__/\  / \_______ \______  /
#        \/          \/      \/
# faststrap.sh --- Fast bootstrapping script
# Copyright (c) 2021-present Sourajyoti Basak
# Author: Sourajyoti Basak < wiz28@protonmail.com >
# URL: https://github.com/wizard-28/dotfiles/
# License: MIT
# =============================================================================

# =============================================================================
# Functions
# =============================================================================
stage() {
	echo "$(tput bold)[\e[32mSTAGE\e[0m$(tput bold)]$(tput sgr0) $1"
}

info() {
	echo "$(tput bold)[\e[34mINFO\e[0m$(tput bold)]$(tput sgr0) $1"
}
# =============================================================================

# =============================================================================
# Banner
# =============================================================================
tput bold
echo '    _________   __________________________  ___    ____ 
   / ____/   | / ___/_  __/ ___/_  __/ __ \/   |  / __ \
  / /_  / /| | \__ \ / /  \__ \ / / / /_/ / /| | / /_/ /
 / __/ / ___ |___/ // /  ___/ // / / _, _/ ___ |/ ____/ 
/_/   /_/  |_/____//_/  /____//_/ /_/ |_/_/  |_/_/      
'
tput sgr0
# =============================================================================

# =============================================================================
# Stage 1: Configure the system
# =============================================================================
stage "Configuring the system..."

info "Configuring timezone"
sudo timedatectl set-timezone Asia/Kolkata

info "Optimizing apt sources"
sudo echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-security main restricted universe multiverse
deb cdrom:[Pop_OS 20.04 _Focal Fossa_ - Release amd64 (20200702)]/ focal main restricted
deb http://apt.pop-os.org/proprietary focal main" | sudo tee /etc/apt/sources.list > /dev/null
# =============================================================================

