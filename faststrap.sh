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
	echo "\n$(tput bold)[\e[32mSTAGE\e[0m$(tput bold)]$(tput sgr0) $1"
}

info() {
	echo "$(tput bold)[\e[34mINFO\e[0m$(tput bold)]$(tput sgr0) $1"
}
# =============================================================================

# =============================================================================
# Banner
# =============================================================================
tput bold
printf '    _________   __________________________  ___    ____ 
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

info "Setting up SysRq"
sudo sysctl -w kernel.sysrq=1 > /dev/null

info "Optimizing APT sources"
echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-security main restricted universe multiverse
deb cdrom:[Pop_OS 20.04 _Focal Fossa_ - Release amd64 (20200702)]/ focal main restricted
deb http://apt.pop-os.org/proprietary focal main" | sudo tee /etc/apt/sources.list > /dev/null

info "Adding PPAs"
sudo add-apt-repository ppa:nschloe/sway-backports -y > /dev/null
sudo add-apt-repository ppa:nschloe/waybar -y > /dev/null
sudo apt-add-repository ppa:fish-shell/release-3 -y > /dev/null
sudo add-apt-repository ppa:neovim-ppa/unstable -y > /dev/null
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y > /dev/null

info "Updating APT"
sudo apt-get install apt -y > /dev/null

info "Installing configuration files"
sudo apt-get install xutils-dev -y > /dev/null
mkdir -p ~/.doom.d/ ~/.weechat/ ~/.SpaceVim.d/
lndir -silent ~/dotfiles/.config/ ~/.config/
lndir -silent ~/dotfiles/.doom.d/ ~/.doom.d/
lndir -silent ~/dotfiles/.weechat/ ~/.weechat/
lndir -silent ~/dotfiles/.SpaceVim.d/ ~/.SpaceVim.d/
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml

info "Configuring environment variables"
echo 'EDITOR="nvim"\nMOZ_ENABLE_WAYLAND=1' | sudo tee -a /etc/environment > /dev/null
# =============================================================================

# =============================================================================
# Stage 2: Install applications
# =============================================================================
stage "Installing applications..."

info "Installing APT applications"
sudo apt-get install -o Dpkg::Options::="--force-overwrite" -y \
	firefox \
	lua5.3 bat ripgrep fd-find fzf zram-config zram-tools gnome-tweaks gstreamer1.0-plugins-bad \
	libnotify-bin jq light grim slurp playerctl htop wl-clipboard mako-notifier xwayland libgdk-pixbuf2.0-common libgdk-pixbuf2.0-bin gir1.2-gdkpixbuf-2.0 python3-pip \
	sway swayidle sway-backgrounds \
	waybar fonts-font-awesome \
	shellcheck \
	alacritty \
	fish \
	neovim python3.8-venv universal-ctags \
	libfdk-aac1 libldacbt-abr2 libldacbt-enc2 libopenaptx0 \
	gstreamer1.0-pipewire libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules pipewire pipewire-audio-client-libraries pipewire-bin pipewire-locales pipewire-tests > /dev/null

