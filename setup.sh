#!/bin/bash

# Variable to specify the type of installation
INSTALL_TYPE=$1

# List of packages to install
if [ "$INSTALL_TYPE" == "minimal" ]; then
   packages="libsecret gnome-keyring fish hyprland hyprlock neovim stow virt-manager alacritty sddm wofi grim network-manager-applet waybar google-noto-color-emoji-fonts dunst brave-browser hyprland swww hyprpolkitagent"
elif [ "$INSTALL_TYPE" == "workstation" ]; then
   packages="fish neovim stow virt-manager ghostty brave-browser"
else
    echo "❓ Usage: $0 [minimal|workstation]"
    exit 1
fi

# Create the default folders
echo "📁 Creating the default folders"
mkdir -v -p ~/Computer_stuff ~/.local/share

# Add Brave repo
echo "🦁 Adding the Brave repository"
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# Add Ghostty COPR
echo "👻 Adding Ghostty COPR"
sudo dnf copr enable -y scottames/ghostty

if [ "$INSTALL_TYPE" == "minimal" ]; then
   Enable solopasha/hyprland copr repo
   echo "Adding the solopasha/hyprland copr repo"
   sudo dnf copr enable -y solopasha/hyprland
fi

# Install the packages
echo "📦 Installing packages"
sudo dnf install -y $packages

# Check for directories and run stow if they exist
echo "🔗 Stowing the required config files"
<<comment
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
comment
stow -v 1 fonts fontconfig Wallpapers neovim

if [ "$INSTALL_TYPE" == "minimal" ]; then
   Enable lightdm service
   echo "Enabling SDDM"
   sudo systemctl enable sddm.service

   Change the target for the graphical one
   sudo systemctl set-default graphical.target
fi

# Delete some default packages
echo "🗑️ Delete useless default apps"
sudo dnf remove -y libreoffice-core gnome-boxes

# Add user to libvirt, render and video
echo "🤝🏻 Add user to some groups"
sudo usermod -aG libvier,render,video errorteapot

# Change shell for fish
echo "🐟 Change for fish shell"
chsh -s /bin/fish

# Install Rust toolchain
echo "🦀 Installing Rust toolchain"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y

# Install Nix
echo "❄️ Installing Nix"
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon

# Get Nix config files
echo "🌨️ Getting Nix config"
git clone https://github.com/ErrorTeaPot/nix_config ~/Computer_stuff/nix_config
