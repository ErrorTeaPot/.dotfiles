#!/bin/bash

# List of packages to install
packages="libsecret gnome-keyring fish hyprland hyprlock neovim stow virt-manager alacritty sddm wofi grim network-manager-applet waybar google-noto-color-emoji-fonts dunst brave-browser hyprland"

# Add Brave repo

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Enable solopasha/hyprland copr repo
sudo dnf copr enable -y solopasha/hyprland

# Install the packages
sudo dnf install -y $packages

# Check for directories and run stow if they exist
for package in $packages
do
   # Enable case-insensitive pattern matching
   shopt -s nocaseglob

   if [ -d "$package" ]; then
       stow -v 1 "$package"
   fi

   # Disable case-insensitive pattern matching
   shopt -u nocaseglob
done

stow -v 1 fonts fontconfig Wallpapers starship

# Enable lightdm service
sudo systemctl enable sddm.service

# Change the target for the graphical one
sudo systemctl set-default graphical.target
