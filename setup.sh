#!/bin/bash

center_text() {
    width=$(tput cols)
    message_size=${#1}

    pad_size=$((($width - $message_size) / 2))
    extra_size=$((1 - ($message_size % 2)))

    printf "\e[32m"
    printf "%0.s-" $(seq 1 $pad_size)
    printf "$1"
    printf "%0.s-" $(seq 1 $pad_size)
    printf "\n"
    printf "\e[0m"
}

write_log() {
    timestamp=$(date +"%Y-%m-%d %H:%m:%S")
    printf "[%s] %s\n" "$timestamp" "$1"
}

cd ~

# Update the systeem
center_text "Updating the system"
sudo pacman -Syu --noconfirm
write_log "Done"

# Update firmware
center_text "Updating firmware"
sudo pacman -S --noconfirm linux-firmware
sudo systemctl restart NetworkManager
write_log "Done"

# Install yay
center_text "Install yay"
sudo pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si --noconfirm
cd ~
write_log "Done"

# Update yay
center_text "Update yay"
yay -Syu --noconfirm
write_log "Done"

# Install
center_text "Install packages"
yay -S --noconfirm \
    fish \
    ttf-jetbrains-mono-nerd \
    tofi \
    eww \
    keyd \
    hyprland \
    bat \
    kitty \
    fd \
    fzf \
    lsd \
    neovim \
    neovide \
    ripgrep \
    starship \
    zoxide \
    croc \
    curl \
    dua-cli \
    sd \
    duf \
    procs \
    tre-command \
    neofetch \
    bottom \
    git-delta \
    sd \
    tealdeer \
    rslsync \
    github-cli
write_log "Done"

# Set default shell to fish
center_text "Setting default shell to fish"
chsh -s $(which fish)
write_log "Done"

# Setup eww
center_text "Setup eww"
chmod +x ~/.config/eww/scripts/*
write_log "Done"

# TODO: Add keyd configuration

# Setup github-cli
center_text "Setup github-cli"
gh auth login -p https -w
write_log "Done"

# Install resilio-sync
center_text "Setup resilio-sync"
mkdir -p ~/.config/rslsync ~/.sync
gh repo clone lewohy/rslsync ~/.config/rslsync
systemctl enable rslsync.service
systemctl start rslsync.service
write_log "Done"

# timedatectl(듀얼부팅시 윈도우-리눅스 시간안맞는 문제 해결)
center_text "Fixing time issue"
timedatectl set-local-rtc 1 --adjust-system-clock
write_log "Done"
