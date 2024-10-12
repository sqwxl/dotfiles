abbr n nvim
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR

abbr s sudo
abbr se sudoedit

abbr dc 'docker compose'

abbr mv "mv -iv"
abbr cp "cp -riv"
abbr mkdir "mkdir -vp"

abbr cfgsway "cd ~/.config/sway && $EDITOR config"
abbr cfgvim "cd ~/.config/nvim && $EDITOR init.lua"
abbr cfgfish "cd ~/.config/fish && $EDITOR config.fish"
abbr cfgterm "cd ~/.config/foot && $EDITOR foot.ini"

# Weather in Stukely
abbr weather 'curl -s "wttr.in/45.32,-72.42?nFQ"'

if test "$TERM" = foot -o "$TERM" = foot-extra
    abbr ssh "TERM=linux command ssh"
end

if type -q eza
    alias ls 'eza --icons --group-directories-first'
end

abbr l ls
abbr ll 'ls -l'
abbr lll 'ls -lah'

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

fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/.cargo/bin

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

source "$__fish_config_dir/functions/__auto_source_venv.fish"
