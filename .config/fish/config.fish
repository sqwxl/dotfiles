abbr -a n nvim
set -gx EDITOR nvim
set -gx VISUAL nvim

abbr -a s sudo
abbr -a se sudoedit
abbr -a dc 'docker compose'

abbr --add cfgsway "cd ~/.config/sway && $EDITOR config"
abbr --add cfgvim "cd ~/.config/nvim && $EDITOR init.lua"
abbr --add cfgfish "cd ~/.config/fish && $EDITOR config.fish"
abbr --add cfgterm "cd ~/.config/foot && $EDITOR foot.ini"

if test "$TERM" = foot -o "$TERM" = foot-extra
    abbr --add ssh "TERM=linux command ssh"
end

if type -q eza
    alias ls eza
else if type -q exa
    alias ls exa
else if type -q lsd
    alias ls lsd
end

abbr --add l ls
abbr --add ll 'ls -l'
abbr --add lll 'ls -lah'

if type -q fzf
    fzf --fish | source
end

if type -q fd
    set -gx FZF_DEFAULT_COMMAND fd --type file
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
end

if type -q bat
    alias cat bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx MANROFFOPT -c
    set -gx BAT_THEME gruvbox-dark
    set -gx FZF_CTRL_T_OPTS --preview '"bat --color=always --style=numbers --line-range=:500 {}"'
end

if type -q go
    if test -z "$GOPATH"
        set -gx GOPATH "$HOME/go"
    end
    fish_add_path $GOPATH/bin
end

if type -q node
    fish_add_path $HOME/.npm-global/bin
end

if type -q cargo
    fish_add_path $HOME/.cargo/bin
end

if type -q zoxide
    zoxide init fish | source
end

alias zz 'cd -'

if type -q starship
    starship init fish | source
end

if type -q direnv
    direnv hook fish | source
end

source "$HOME/.config/fish/functions/__auto_source_venv.fish"
