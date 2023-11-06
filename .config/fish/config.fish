set -gx EDITOR nvim
set -gx VISUAL nvim
if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    alias cat bat
else if type -q batcat
    set -gx MANPAGER "sh -c 'col -bx | batcat -l man -p'"
    alias cat batcat
    alias bat batcat
end
set -gx MANROFFOPT -c
set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"

if test "$TERM" = foot -o "$TERM" = foot-extra
    alias ssh "TERM=linux command ssh"
end

abbr -ag n nvim
abbr -ag s sudo
abbr -ag se sudoedit

abbr -ag g git
abbr -ag gs 'git status'
abbr -ag gd 'git diff'
abbr -ag gb 'git branch'
abbr -ag gl 'git log'
abbr -ag glo 'git log --oneline'
abbr -ag gr 'git reflog'
abbr -ag ga 'git add'
abbr -ag gaa 'git add .'
abbr -ag gcm 'git commit -m'
abbr -ag gcam 'git commit -a -m'
abbr -ag gcan 'git commit --amend --no-edit'
abbr -ag gf 'git fetch'
abbr -ag gp 'git push'
abbr -ag gr 'git remote -v'

abbr -ag rmr 'rm -rf'

alias cfginit "git init --bare $HOME/.dotfiles && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME remote add origin && echo .dotfiles >> $HOME/.gitignore"
alias cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
abbr -ag cfgsway "cd ~/.config/sway && $EDITOR config"
abbr -ag cfgvim "cd ~/.config/nvim && $EDITOR init.lua"
abbr -ag cfgfish "cd ~/.config/fish && $EDITOR config.fish"
if test "$TERM" = kitty
    abbr -ag cfgterm "cd ~/.config/kitty && $EDITOR kitty.conf"
else if test "$TERM" = foot-extra
    abbr -ag cfgterm "cd ~/.config/foot && $EDITOR foot.ini"
end

abbr -ag myip "curl -4 icanhazip.com"

if type -q exa
    abbr -ag l exa
    abbr -ag ll 'exa -l'
    abbr -ag lll 'exa -la'
    alias ls exa
else if type -q lsd
    abbr -ag l lsd
    abbr -ag ll 'lsd -l'
    abbr -ag lll 'lsd -lah'
    alias ls lsd
else
    abbr -ag l ls
    abbr -ag ll 'ls -l'
    abbr -ag lll 'ls -lah'
end

if type -q rg
    set -gx FZF_DEFAULT_COMMAND rg --files
    set -gx FZF_DEFAULT_OPTS -m
end

if type -q go
    if test -z "$GOPATH"
        set -gx GOPATH "$HOME/go"
    end
    fish_add_path $GOPATH/bin/
end

if type -q node
    if not test -d $HOME/.npm-global/bin
        mkdir -p $HOME/.npm-global/bin
    end
    npm config set prefix $HOME/.npm-global
    fish_add_path $HOME/.npm-global/bin
end

if type -q cargo
    fish_add_path $HOME/.cargo/bin
    # alias rust-analyzer 'rustup run stable rust-analyzer'
end

# if type -q fdfind
#   alias fd fdfind
# end

if type -q zoxide
    zoxide init fish | source
end

# Generated for envman. Do not edit.
# test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

complete -c cht.sh -xa '(curl -s cht.sh/:list)'

if type -q starship
    starship completions fish >~/.config/fish/completions/starship.fish
    starship init fish | source
end

if type -q direnv
    direnv hook fish | source
end

source "$HOME/.config/fish/functions/__auto_source_venv.fish"

# fish_default_key_bindings -M insert
# Then execute the vi-bindings so they take precedence when there's a conflict.
# Without --no-erase fish_vi_key_bindings will default to
# resetting all bindings.
# The argument specifies the initial mode (insert, "default" or visual).
# fish_vi_key_bindings --no-erase insert
