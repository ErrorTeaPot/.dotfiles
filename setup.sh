#!/bin/bash

# List of packages to install
packages="libsecret gnome-keyring fish hyprland hyprlock neovim stow virt-manager alacritty sddm wofi grim network-manager-applet waybar google-noto-color-emoji-fonts dunst brave-browser hyprland swww hyprpolkitagent"

# Create the default folders
echo "Creating the default folders"
mkdir -v -p Computer_stuff Pictures .local/share

# Add Brave repo
echo "Adding the Brave repository"
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Enable solopasha/hyprland copr repo
echo "Adding the solopasha/hyprland copr repo"
sudo dnf copr enable -y solopasha/hyprland

# Install the packages
echo "Installing packages"
sudo dnf install -y $packages

# Check for directories and run stow if they exist
echo "Stowing the required config files"
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
echo "Enabling SDDM"
sudo systemctl enable sddm.service

# Change the target for the graphical one
sudo systemctl set-default graphical.target
