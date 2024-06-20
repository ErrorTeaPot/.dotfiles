[![Commits][commits-shield]][commits-url]

Those are my dotfiles, there is the softwares I am curently using :

- 🖥️ WM : hyprland
- 🔔 Notifications : dunst
- ℹ️ Topbar : waybar
- 🚀 App launcher : fuzzel
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

Let's say I would like to use the fish config, then I need to do :
```
stow fish
```

With this command stow will create a symlink that points to the config file the repo contains.

**WARNING :** If there is already dotfiles where stow want to create the symlink, please remove the entire folder to get the link being as the entire folder.
It is not required but cleaner. 

For more information about this tool, check online.
