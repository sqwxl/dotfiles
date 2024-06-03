set -gx EDITOR nvim
set -gx VISUAL nvim

abbr --add s sudo
abbr --add g git
abbr --add n nvim
abbr --add se sudoedit

abbr --add l ls
abbr --add ll 'ls -l'
abbr --add lll 'ls -lah'

abbr --add gr "cd (git rev-parse --show-toplevel 2>/dev/null || $PWD)"
abbr --add gs 'git status'

alias cfginit "git init --bare $HOME/.dotfiles && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME remote add origin && echo .dotfiles >> $HOME/.gitignore"
alias cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
abbr --add cfgsway "cd ~/.config/sway && $EDITOR config"
abbr --add cfgvim "cd ~/.config/nvim && $EDITOR init.lua"
abbr --add cfgfish "cd ~/.config/fish && $EDITOR config.fish"
if test "$TERM" = kitty
    abbr --add cfgterm "cd ~/.config/kitty && $EDITOR kitty.conf"
else if test "$TERM" = foot-extra
    abbr --add cfgterm "cd ~/.config/foot && $EDITOR foot.ini"
end

if test "$TERM" = foot -o "$TERM" = foot-extra
    alias ssh "TERM=linux command ssh"
end

if type -q eza
    alias ls eza
else if type -q exa
    alias ls exa
else if type -q lsd
    alias ls lsd
end

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
    fish_add_path (npm prefix --global)/bin
end

if type -q cargo
    fish_add_path $HOME/.cargo/bin
end

if type -q zoxide
    zoxide init fish | source
end

complete -c cht.sh -xa '(curl -s cht.sh/:list)'

if type -q starship
    starship init fish | source
end

if type -q direnv
    direnv hook fish | source
end

source "$HOME/.config/fish/functions/__auto_source_venv.fish"
