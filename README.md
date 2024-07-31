[![Commits][commits-shield]][commits-url]

Those are my dotfiles, there is the softwares I am curently using :

- 🖥️ WM : hyprland
- 🔔 Notifications : dunst
- ℹ️ Topbar : waybar
- 🚀 App launcher : wofi
- 🐈 Terminal : alacritty
- 🐟 Shell : fish
- 💫 Shell prompt : starship
- 🐧 Linux distro : Fedora workstation
  
There is also dotfiles from other softwares that i am not currently using by it is here for backup purposes.

[commits-shield]: https://img.shields.io/github/commit-activity/t/ErrorTeaPot/.dotfiles
[commits-url]: https://github.com/ErrorTeaPot/.dotfiles/graphs/commit-activity

# Installation

I am managing my dotfiles using [Stow]([URL](https://www.gnu.org/software/stow/)).
This software allows to create symlinks that points to the dotfile you want to use. 

1. Clone the repo in your home directory :
```bash
git clone https://github.com/ErrorTeaPot/.dotfiles.git
```
2. Go into the directory and stow the folder you would like to grab the files of.
```bash
stow <folder name>
```
With this command stow will create a symlink that points to the config file the repo contains.

---
**WARNING :** If there is already dotfiles where stow want to create the symlink, please remove the entire folder to get the link being as the entire folder.
It is not required but cleaner. 

For more information about this tool, check online.

---

At the end, you will end up with something like this :
```bash
~/.config
🌶️ tree -L 1                                                                                                     (base)
.
├── fish -> ../.dotfiles/fish/.config/fish
├── fontconfig -> ../.dotfiles/fontconfig/.config/fontconfig
└── starship.toml -> ../.dotfiles/starship/.config/starship.toml
```
