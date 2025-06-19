fish_config theme choose "Rosé Pine Moon"

if status is-interactive
    starship init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"

# Use fish_add_path to prepend paths to PATH
fish_add_path --prepend $BUN_INSTALL/bin

set -e CARGO_HOME
set -Ux CARGO_HOME $HOME/.config/cargo

set -e EDITOR
set -Ux EDITOR /bin/nvim

set -e RUSTUP_HOME
set -Ux RUSTUP_HOME $HOME/.config/rustup

set -e SSH_AUTH_SOCK
set -Ux SSH_AUTH_SOCK /run/user/1000/gcr/ssh

set -e XDG_CONFIG_HOME
set -Ux XDG_CONFIG_HOME $HOME/.config

# Use fish_add_path to prepend paths to fish_user_paths
fish_add_path --prepend $HOME/.local/bin
fish_add_path --prepend $HOME/.config/cargo/bin
