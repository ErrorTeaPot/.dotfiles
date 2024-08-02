#!/bin/bash

# List of packages to install
packages="libsecret gnome-keyring fish hyprland hyprlock neovim stow virt-manager alacritty lightdm lightdm-gtk wofi grim"

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

# Enable lightdm service
sudo systemctl enable lightdm.service

# Change the target for the graphical one
sudo systemctl set-default graphical.target
