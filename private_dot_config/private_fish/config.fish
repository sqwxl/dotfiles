alias n nvim
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR

abbr devim "devcontainer exec --workspace-folder . nvim"

abbr s sudo
abbr se sudoedit

abbr dc "docker compose"

abbr rm "rm -v"
abbr mv "mv -iv"
abbr cp "cp -riv"
abbr mkdir "mkdir -vp"

# Weather in Stukely
abbr weather 'curl -s "wttr.in/45.32,-72.42?nFQ"'

if command -q chezmoi
    alias cz chezmoi
    abbr czsway "cz edit --apply ~/.config/sway/config"
    abbr czvim "cz edit --apply ~/.config/nvim/lua"
    abbr czfish "cz edit --apply ~/.config/fish/config.fish"
    abbr czterm "cz edit --apply ~/.config/foot/foot.ini"
end

if test "$TERM" = foot -o "$TERM" = foot-extra
    abbr ssh "TERM=linux command ssh"
end

if command -q eza
    alias ls eza
    alias l eza
    alias l. "eza --treat-dirs-as-files --group-directories-first .*"
    alias l1 "eza --oneline"
    alias ll "eza --icons=auto --long --group-directories-first"
    alias lll "eza --icons=auto --all --header --long --group-directories-first"
end

if command -q fzf
    fzf --fish | source
    if command -q fd
        set -gx FZF_DEFAULT_COMMAND fd --type file --strip-cwd-prefix --hidden --follow --exclude .git
        set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    end
    command -q bat; and set -gx FZF_CTRL_T_OPTS --preview '"bat --color=always --style=numbers --line-range=:500 {}"'
end

if command -q bat
    alias cat bat
    abbr --position anywhere -- --help "--help | bat --plain --language help"
    set -gx MANPAGER "bat --plain --language man"
    set -gx BAT_THEME gruvbox-dark
end

if command -q go
    if test -z "$GOPATH"
        set -gx GOPATH $HOME/go
    end
    fish_add_path $GOPATH/bin
end

command -q direnv; and direnv hook fish | source

if command -q fnm
    fnm env --use-on-cd --corepack-enabled --version-file-strategy=recursive --shell fish | source
end

if status is-interactive
    command -q starship; and starship init fish | source
    command -q zoxide; and zoxide init fish | source
    command -q rbenv; and rbenv init - --no-rehash fish | source
    alias zz "cd -"
end

if command -q devcontainer
    abbr nd 'devcontainer up --mount "type=bind,source=$HOME/.config/nvim,target=/home/vscode/.config/nvim" --workspace-folder . && devcontainer exec --worspace-folder .'
end

fish_add_path --prepend --move $HOME/.npm-global/bin
fish_add_path --prepend --move $HOME/.cargo/bin
fish_add_path --prepend --move $HOME/.local/bin

source "$__fish_config_dir/functions/__auto_source_venv.fish"
