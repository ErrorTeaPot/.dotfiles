#!/bin/bash

# List of packages to install
packages="libsecret gnome-keyring fish hyprland hyprlock neovim stow virt-manager"

# Install the packages
sudo dnf install $packages

# Check for directories and run stow if they exist
for package in $packages
do
   if [ -d "$package" ]; then
       stow "$package"
   fi
done
