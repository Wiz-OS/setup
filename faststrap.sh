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
# Author: Sourajyoti Basak <wiz28@protonmail.com>
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
# Stage 1: Pre-configurations
# =============================================================================
stage "Starting pre-configurations..."

echo "deb http://us.archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse
deb http://us.archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse
deb http://us.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse
deb http://us.archive.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://apt.pop-os.org/proprietary jammy main" | tee /etc/apt/sources.list > /dev/null

info "Installing base packages"
apt-get update
apt-get install sudo git curl gpg software-properties-common -y

info "Configuring timezone"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime

info "Setting up SysRq"
echo 'kernel.sysrq = 1' >> /etc/sysctl.conf

info "Adding PPAs"
echo 'deb http://download.opensuse.org/repositories/home:/Head_on_a_Stick:/azote/xUbuntu_20.04/ /' | tee /etc/apt/sources.list.d/home:Head_on_a_Stick:azote.list > /dev/null
curl -fsSL https://download.opensuse.org/repositories/home:Head_on_a_Stick:azote/xUbuntu_20.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_Head_on_a_Stick_azote.gpg > /dev/null
add-apt-repository ppa:git-core/ppa -yn > /dev/null
add-apt-repository ppa:nschloe/sway-backports -yn > /dev/null
add-apt-repository ppa:nschloe/waybar -yn > /dev/null
add-apt-repository ppa:dtl131/mpdbackport -yn > /dev/null
apt-add-repository ppa:fish-shell/release-3 -yn > /dev/null
add-apt-repository ppa:neovim-ppa/unstable -yn > /dev/null
add-apt-repository ppa:pipewire-debian/pipewire-upstream -y > /dev/null

info "Updating APT"
apt-get install apt -y > /dev/null

info "Installing configuration files"
apt-get install xutils-dev -y > /dev/null
# =============================================================================

# =============================================================================
# Stage 2: Create user
# =============================================================================
stage "Creating user..."

adduser --disabled-password --gecos '' wizard
adduser wizard sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

su wizard -c 'cd && git clone https://github.com/Wiz-OS/setup dotfiles
mkdir -p ~/.doom.d/ ~/.weechat/ ~/.librewolf/ ~/.config
lndir ~/dotfiles/.config/ ~/.config/
lndir ~/dotfiles/.doom.d/ ~/.doom.d/
lndir ~/dotfiles/.weechat/ ~/.weechat/
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/.config/starship/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/.azotebg ~/.azotebg
ln -sf ~/dotfiles/.librewolf/librewolf.overrides.cfg ~/.librewolf/librewolf.overrides.cfg'

info "Configuring environment variables"
echo 'EDITOR="nvim"\nMOZ_ENABLE_WAYLAND=1' | tee -a /etc/environment > /dev/null
# =============================================================================

# =============================================================================
# Stage 3: Install applications
# =============================================================================

stage "Installing applications..."

info "Installing Pacstall applications."
su wizard -c 'cd /tmp && curl -fsSL https://git.io/Jue3Z > pacstall-install.sh # Pacstall (develop branch installer)
chmod +x ./pacstall-install.sh
yes | sudo ./pacstall-install.sh
sudo rm ./pacstall-install.sh
pacstall -U pacstall develop
pacstall -PI librewolf-app bemenu-git shfmt-bin shellharden-bin dunst treefetch-bin git-delta-deb

info "Installing APT applications"
sudo apt-get install -o Dpkg::Options::="--force-overwrite" -y \
    lua5.3 bat ripgrep fd-find fzf zram-config zram-tools gnome-tweaks gstreamer1.0-plugins-bad \
    libnotify-bin jq light grim slurp playerctl htop wl-clipboard xwayland libgdk-pixbuf2.0-common libgdk-pixbuf2.0-bin gir1.2-gdkpixbuf-2.0 python3-pip \
    sway swayidle sway-backgrounds azote \
    waybar fonts-font-awesome \
    shellcheck \
    alacritty \
    fish \
    newsboat \
    neovim universal-ctags \
    mpd mpc ncmpcpp \
    libldacbt-abr2 libldacbt-enc2 libopenaptx0 \
    gstreamer1.0-pipewire libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules pipewire pipewire-audio-client-libraries pipewire-bin pipewire-locales pipewire-tests > /dev/null

info "Installing PIP applications"
sudo pip3 install \
    autotiling \
    pynvim black \
    cmake > /dev/null
info "Installing Xanmod kernel"
wget -O- https://dl.xanmod.org/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod.gpg
echo "deb [signed-by=/usr/share/keyrings/xanmod.gpg] http://deb.xanmod.org releases main" | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list
sudo apt-get update
sudo apt install linux-xanmod'

info "Installing applications"
install -Dm6755 binaries/swaylock /usr/local/bin/
install -Dm755 binaries/clipman /bin/

# ncmpcpp 0.9.2
# (
#     sudo cp /media/pop-os/SBASAK/ncmpcpp/lib*.so* /usr/lib/x86_64-linux-gnu/                   # Install libs
#     sudo apt-get install -y /media/pop-os/SBASAK/ncmpcpp/libicu67_67.1-7_amd64.deb > /dev/null # Install deb dependency
#     sudo install -D /media/pop-os/SBASAK/ncmpcpp/ncmpcpp /usr/bin                              # Install ncmpcpp binary
# ) &

info "Installing CURL applications"
# Fonts
curl -sfLo "/usr/share/fonts/truetype/JetBrains Mono NL Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Regular/complete/JetBrains%20Mono%20NL%20Regular%20Nerd%20Font%20Complete.ttf
curl -sfLo "/usr/share/fonts/truetype/JetBrains Mono NL Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/NoLigatures/Italic/complete/JetBrains%20Mono%20NL%20Italic%20Nerd%20Font%20Complete.ttf
fc-cache -f

# Application
sudo -u wizard bash -c 'curl -sS https://webinstall.dev/zoxide | bash > /dev/null'
sudo curl -sfLo /usr/local/bin/grimshot https://raw.githubusercontent.com/swaywm/sway/master/contrib/grimshot
sudo chmod +x /usr/local/bin/grimshot
sudo -u wizard bash -c 'curl -sSL https://install.python-poetry.org | python3 - > /dev/null'

mkdir exa/
cd exa/ || exit
curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep "browser_download_url" | grep "exa-linux-x86_64-v" | cut -d '"' -f 4 | wget -qi -
unzip -q exa*
sudo mv bin/exa /usr/local/bin
sudo mv man/exa.1 /usr/share/man/man1/
sudo mv completions/exa.fish /usr/share/fish/vendor_completions.d/
sudo mv completions/exa.bash /etc/bash_completion.d/
cd .. && rm -r exa/

curl -sL install-node.now.sh/lts | sudo bash
curl -fsSL https://starship.rs/install.sh | sudo sh
# =============================================================================

# =============================================================================
# Stage 4: Purge bloat
# =============================================================================
stage "Purging bloat..."

info "Purging APT bloat"
apt-get purge firefox libreoffice-common geary totem suckless-tools gnome-contacts gnome-weather gnome-calender gnome-remote-desktop gnome-accessibility-themes gnome-user-docs ubuntu-docs language-pack-de language-pack-es language-pack-fr language-pack-ru language-pack-ja language-pack-ar pop-installer -y > /dev/null
apt-get autoremove --purge -y > /dev/null
# =============================================================================

# =============================================================================
# Stage 5: Postconfigurations
# =============================================================================
stage "Starting postconfigurations..."

info "Adding bat symlink"
mkdir -p /home/wizard/.local/bin
ln -s /usr/bin/batcat /home/wizard/.local/bin/bat

info "Changing default shell"
sudo chsh -s /usr/bin/fish
# CHANGE THIS WIZARD I BEG YOU
yes $(echo "1234") | sudo passwd wizard

info "Setting up ZSWAP"
sudo swapoff -a > /dev/null
sudo zramctl /dev/zram0 --size 750M > /dev/null 2>&1
sudo zramctl /dev/zram1 --size 750M > /dev/null 2>&1
sudo zramctl /dev/zram2 --size 750M > /dev/null 2>&1
sudo zramctl /dev/zram3 --size 750M > /dev/null 2>&1
# sudo zramswap start > /dev/null 2>&1

info "Setting up Pipewire"
systemctl --user --now disable pulseaudio.socket pulseaudio.service > /dev/null 2>&1
systemctl --user mask pulseaudio > /dev/null 2>&1
systemctl --user --now enable pipewire.socket pipewire-pulse.socket pipewire.service pipewire-pulse.service pipewire-media-session.service > /dev/null 2>&1

info "Optimizing APT sources"
echo "deb mirror://mirrors.ubuntu.com/mirrors.txt jammy main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt jammy-updates main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt jammy-backports main restricted universe multiverse
deb mirror://mirrors.ubuntu.com/mirrors.txt jammy-security main restricted universe multiverse
deb cdrom:[Pop_OS 20.04 _Focal Fossa_ - Release amd64 (20200702)]/ jammy main restricted
deb http://apt.pop-os.org/proprietary jammy main" | tee /etc/apt/sources.list > /dev/null

info "Setting default session"
cat > /usr/share/xsessions/pop.desktop <<EOF
[Desktop Entry]
Name=Sway
Comment=This session logs you into Sway
Exec=/usr/bin/sway
TryExec=/usr/bin/sway
Type=Application
DesktopNames=pop:GNOME
X-GDM-SessionRegisters=true
X-Ubuntu-Gettext-Domain=gnome-session-3.0
EOF

# info "Setting up SSH and GPG keys"
# sudo cp -r /media/pop-os/SBASAK/.ssh/ ~
# sudo chown "$USER":"$USER" ~/.ssh/id_ed25519*
# chmod 600 ~/.ssh/id_ed25519
# chmod 644 ~/.ssh/id_ed25519.pub
# eval "$(ssh-agent)" > /dev/null
#
# notify-send "Enter password for SSH and GPG key"
# xclip -selection c < /media/pop-os/SBASAK/SSH
# ssh-add ~/.ssh/id_ed25519
# xclip -selection c < /media/pop-os/SBASAK/GPG
# gpg --import /media/pop-os/SBASAK/GPG.asc

wait
cd /root
# cleanup
rm -r setup
# =============================================================================
