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
# Stage 1: Preconfigurations
# =============================================================================
stage "Starting preconfigurations..."

info "Configuring timezone"
sudo timedatectl set-timezone Asia/Kolkata &

info "Setting up SysRq"
sudo sysctl -w kernel.sysrq=1 > /dev/null &

info "Optimizing APT sources"
echo "deb mirror://mirrors.ubuntu.com/mirrors.txt focal main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt focal-security main restricted universe multiverse
deb cdrom:[Pop_OS 20.04 _Focal Fossa_ - Release amd64 (20200702)]/ focal main restricted
deb http://apt.pop-os.org/proprietary focal main" | sudo tee /etc/apt/sources.list > /dev/null

info "Adding PPAs"
echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/azote/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:Head_on_a_Stick:azote.list > /dev/null
curl -fsSL https://download.opensuse.org/repositories/home:Head_on_a_Stick:azote/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_Head_on_a_Stick_azote.gpg > /dev/null || ../setup.sh
sudo add-apt-repository ppa:git-core/ppa -yn > /dev/null || ../setup.sh
sudo add-apt-repository ppa:nschloe/sway-backports -yn > /dev/null || ../setup.sh
sudo add-apt-repository ppa:nschloe/waybar -yn > /dev/null || ../setup.sh
sudo add-apt-repository ppa:dtl131/mpdbackport -yn > /dev/null || ../setup.sh
sudo apt-add-repository ppa:fish-shell/release-3 -yn > /dev/null || ../setup.sh
sudo add-apt-repository ppa:neovim-ppa/unstable -yn > /dev/null || ../setup.sh
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -y > /dev/null || ../setup.sh

info "Updating APT"
sudo apt-get install apt -y > /dev/null || .../setup.sh

info "Installing configuration files"
sudo apt-get install xutils-dev -y > /dev/null || .../setup.sh
(
mkdir -p ~/.doom.d/ ~/.weechat/ ~/.SpaceVim.d/ ~/.librewolf/
lndir -silent ~/dotfiles/.config/ ~/.config/
lndir -silent ~/dotfiles/.doom.d/ ~/.doom.d/
lndir -silent ~/dotfiles/.weechat/ ~/.weechat/
lndir -silent ~/dotfiles/.SpaceVim.d/ ~/.SpaceVim.d/
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/.azotebg ~/.azotebg
ln -sf ~/dotfiles/.librewolf/librewolf.overrides.cfg ~/.librewolf/librewolf.overrides.cfg
) &

info "Configuring environment variables"
echo 'EDITOR="nvim"\nMOZ_ENABLE_WAYLAND=1' | sudo tee -a /etc/environment > /dev/null &
# =============================================================================

# =============================================================================
# Stage 2: Install applications
# =============================================================================
stage "Installing applications..."

info "Installing Pacstall applications."
curl -fsSL https://git.io/Jue3Z > pacstall-install.sh # Pacstall (develop branch installer)
chmod +x ./pacstall-install.sh
yes | sudo ./pacstall-install.sh > /dev/null 2>&1
rm ./pacstall-install.sh
pacstall -U pacstall develop > /dev/null
pacstall -PI librewolf-app bemenu-git shfmt-bin treefetch-bin git-delta-deb > /dev/null 2>&1

info "Installing APT applications"
sudo apt-get install -o Dpkg::Options::="--force-overwrite" -y \
	lua5.3 bat ripgrep fd-find fzf zram-config zram-tools gnome-tweaks gstreamer1.0-plugins-bad \
	libnotify-bin jq light grim slurp playerctl htop wl-clipboard mako-notifier xwayland libgdk-pixbuf2.0-common libgdk-pixbuf2.0-bin gir1.2-gdkpixbuf-2.0 python3-pip \
	sway swayidle sway-backgrounds azote \
	waybar fonts-font-awesome \
	shellcheck \
	alacritty \
	fish \
	newsboat \
	neovim python3.8-venv universal-ctags \
	mpd mpc ncmpcpp \
	libfdk-aac1 libldacbt-abr2 libldacbt-enc2 libopenaptx0 \
	gstreamer1.0-pipewire libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules pipewire pipewire-audio-client-libraries pipewire-bin pipewire-locales pipewire-tests > /dev/null

info "Installing PIP applications"
sudo pip3 install \
	autotiling \
	pynvim black \
	cmake > /dev/null &

info "Installing applications from USB"
sudo install -Dm6755 /media/pop-os/SBASAK/swaylock /usr/local/bin/ &
sudo install -Dm755 /media/pop-os/SBASAK/clipman /bin/ &

# ncmpcpp 0.9.2
(
sudo cp /media/pop-os/SBASAK/ncmpcpp/lib*.so* /usr/lib/x86_64-linux-gnu/ # Install libs
sudo apt-get install -y /media/pop-os/SBASAK/ncmpcpp/libicu67_67.1-7_amd64.deb > /dev/null # Install deb dependency
sudo install -D /media/pop-os/SBASAK/ncmpcpp/ncmpcpp /usr/bin # Install ncmpcpp binary
) &


info "Installing CURL applications"
# Fonts
(
sudo curl -sfLo "/usr/share/fonts/truetype/JetBrains Mono NL Regular Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20NL%20Regular%20Nerd%20Font%20Complete%20Mono.ttf
sudo curl -sfLo "/usr/share/fonts/truetype/JetBrains Mono NL Italic Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20NL%20Italic%20Nerd%20Font%20Complete%20Mono.ttf
fc-cache -f
) &

# Application
(
curl -sS https://webinstall.dev/zoxide | bash > /dev/null
) &
(
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish > /dev/null
fish --command "omf install https://github.com/wfxr/forgit" > /dev/null
) &
(
sudo curl -sfLo /usr/local/bin/grimshot https://raw.githubusercontent.com/swaywm/sway/master/contrib/grimshot
sudo chmod +x /usr/local/bin/grimshot
) &
(
curl -sSL https://install.python-poetry.org | python3 - > /dev/null
) &

(
mkdir exa/
cd exa/ || exit
curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep "browser_download_url" | grep "exa-linux-x86_64-v" | cut -d '"' -f 4 | wget -qi -
unzip -q exa*
sudo mv bin/exa /usr/local/bin
sudo mv man/exa.1 /usr/share/man/man1/
sudo mv completions/exa.fish /usr/share/fish/vendor_completions.d/
sudo mv completions/exa.bash /etc/bash_completion.d/
cd .. && rm -r exa/
) &

notify-send --urgency critical "Interaction required"
curl -sL install-node.now.sh/lts | sudo bash
curl -fsSL https://starship.rs/install.sh | sudo sh
# =============================================================================

# =============================================================================
# Stage 3: Purge bloat
# =============================================================================
stage "Purging bloat..."

info "Purging APT bloat"
(
sudo apt-get purge firefox libreoffice-common geary totem suckless-tools -y > /dev/null
sudo apt-get autoremove --purge -y > /dev/null
) &
# =============================================================================

# =============================================================================
# Stage 4: Postconfigurations
# =============================================================================
stage "Starting postconfigurations..."

info "Adding bat symlink"
(
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
) &

info "Changing default shell"
(
yes "$(cat /media/pop-os/SBASAK/passwd)" | sudo passwd "$(logname)" > /dev/null 2>&1
yes "$(cat /media/pop-os/SBASAK/passwd)" | chsh -s /usr/bin/fish > /dev/null 2>&1
) &

info "Setting up ZSWAP"
(
sudo swapoff -a > /dev/null
sudo zramctl /dev/zram0 --size 750M > /dev/null 2>&1
sudo zramctl /dev/zram1 --size 750M > /dev/null 2>&1
sudo zramctl /dev/zram2 --size 750M > /dev/null 2>&1
sudo zramctl /dev/zram3 --size 750M > /dev/null 2>&1
sudo zramswap start > /dev/null 2>&1
) &

info "Setting up Pipewire"
(
systemctl --user --now disable pulseaudio.socket pulseaudio.service > /dev/null 2>&1
systemctl --user mask pulseaudio > /dev/null 2>&1
systemctl --user --now enable pipewire.socket pipewire-pulse.socket pipewire.service pipewire-pulse.service pipewire-media-session.service > /dev/null 2>&1
) &

info "Setting up git"
(
# Setup remote
cd ~/dotfiles || exit
git remote set-url origin git@github.com:wizard-28/dotfiles.git
) &

info "Setting up SSH and GPG keys"
sudo cp -r /media/pop-os/SBASAK/.ssh/ ~
sudo chown "$USER":"$USER" ~/.ssh/id_ed25519*
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
eval "$(ssh-agent)" > /dev/null

notify-send "Enter password for SSH and GPG key"
xclip -selection c < /media/pop-os/SBASAK/SSH
ssh-add ~/.ssh/id_ed25519
xclip -selection c < /media/pop-os/SBASAK/GPG
gpg --import /media/pop-os/SBASAK/GPG.asc 

wait
# =============================================================================
# Finish up
# =============================================================================
notify-send --urgency critical "Logging out in 10 secs"
sleep 10
sudo service gdm3 stop
# =============================================================================
