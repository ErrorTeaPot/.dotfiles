#!/bin/bash

# List of packages to install
packages=("libsecret" "gnome-keyring" "fish" "hyprland" "hyprlock", "neovim", "stow", "virt-manager")

# Loop through the array and install each package
for package in "${packages[@]}"
do
   sudo dnf install -y "$package"
done
