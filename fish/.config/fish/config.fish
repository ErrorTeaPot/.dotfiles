fish_config theme choose "Rosé Pine Moon"

if status is-interactive
	starship init fish | source
end


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
