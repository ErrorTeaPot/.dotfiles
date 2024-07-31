#!/bin/bash

# List of packages to install
packages="libsecret gnome-keyring fish hyprland hyprlock neovim stow virt-manager alacritty lightdm"

# Install the packages
sudo dnf install $packages

# Check for directories and run stow if they exist
for package in $packages
do
   # Enable case-insensitive pattern matching
   shopt -s nocaseglob

   if [ -d "$package" ]; then
       stow "$package"
   fi

   # Disable case-insensitive pattern matching
   shopt -u nocaseglob
done
