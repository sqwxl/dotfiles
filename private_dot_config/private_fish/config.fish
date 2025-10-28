abbr n nvim
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR

abbr devim 'devcontainer exec --workspace-folder . nvim'

alias cz chezmoi

abbr s sudo
abbr se sudoedit

abbr dc 'docker compose'

abbr rm "rm -v"
abbr mv "mv -iv"
abbr cp "cp -riv"
abbr mkdir "mkdir -vp"

abbr czsway "cz edit --apply ~/.config/sway/config"
abbr czvim "cz edit --apply ~/.config/nvim/lua"
abbr czfish "cz edit --apply ~/.config/fish/config.fish"
abbr czterm "cz edit --apply ~/.config/foot/foot.ini"
abbr czcommit "cz git commit -- -am (openssl rand -hex 4) && cz git push"

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


if type -q zoxide
    zoxide init fish | source
end

alias zz 'cd -'

if type -q starship
    starship init fish | source
end

function prompt_nl --on-event fish_postexec
    echo
end

if type -q direnv
    direnv hook fish | source
end

if type -q fnm
    fnm env --use-on-cd --corepack-enabled --version-file-strategy=recursive --shell fish | source
end

source "$__fish_config_dir/functions/__auto_source_venv.fish"

# Added by `rbenv init` on Tue 24 Jun 2025 10:38:38 EDT
status --is-interactive; and rbenv init - --no-rehash fish | source

fish_add_path --prepend --move $HOME/.npm-global/bin
fish_add_path --prepend --move $HOME/.cargo/bin
fish_add_path --prepend --move $HOME/.local/bin
