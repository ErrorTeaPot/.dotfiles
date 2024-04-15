fish_config theme choose "Dracula Official"

if status is-interactive
	starship init fish | source
	zoxide init fish | source
end
