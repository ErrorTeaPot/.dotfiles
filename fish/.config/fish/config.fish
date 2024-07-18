fish_config theme choose "Rosé Pine Moon"

if status is-interactive
	starship init fish | source
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/errorteapot/Computer_stuff/tools/miniconda/bin/conda
    eval /home/errorteapot/Computer_stuff/tools/miniconda/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/errorteapot/Computer_stuff/tools/miniconda/etc/fish/conf.d/conda.fish"
        . "/home/errorteapot/Computer_stuff/tools/miniconda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/errorteapot/Computer_stuff/tools/miniconda/bin" $PATH
    end
end
# <<< conda initialize <<<

