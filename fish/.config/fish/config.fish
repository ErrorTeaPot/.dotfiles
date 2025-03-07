fish_config theme choose "Rosé Pine Moon"

if status is-interactive
	starship init fish | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

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

set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.config/cargo/bin $fish_user_paths
