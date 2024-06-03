set -gx EDITOR nvim
set -gx VISUAL nvim

abbr -a s sudo
abbr -a g git
abbr -a n nvim
abbr -a se sudoedit

abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gai 'git add --interactive'
abbr -a gap 'git add --patch'
abbr -a gau 'git add --update'
abbr -a gb 'git branch'
abbr -a gba 'git branch --all'
abbr -a gc 'git commit'
abbr -a gca 'git commit --all'
abbr -a gcam 'git commit --all --message'
abbr -a gcan 'git commit --amend --no-edit'
abbr -a gcana 'git commit --amend --no-edit --all'
abbr -a gcfix 'git commit --fixup'
abbr -a gcl 'git clean --interactive -d'
abbr -a gco 'git checkout'
abbr -a gco 'git commit'
abbr -a gcp 'git cherry-pick'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gcsqu 'git commit --squash'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gdup 'git diff @\{upstream\}'
abbr -a gf 'git fetch'
abbr -a gl 'git log --decorate --pretty=oneline --abbrev-commit'
abbr -a glg 'git log --graph --decorate --pretty=oneline --abbrev-commit'
abbr -a glga 'git log --graph --decorate --pretty=oneline --abbrev-commit --all'
abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmc 'git merge --continue'
abbr -a gmt 'git mergetool'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gpl 'git pull'
abbr -a gplr 'git pull --rebase'
abbr -a gplra 'git pull --rebase --autostash'
abbr -a gpristine 'git reset --hard && git clean --force -d -x'
abbr -a gr "cd (git rev-parse --show-toplevel 2>/dev/null || $PWD)"
abbr -a gr 'git reset'
abbr -a grb 'git rebase'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbi 'git rebase --interactive'
abbr -a grh 'git reset --hard'
abbr -a grk 'git reset --keep'
abbr -a grl 'git reflog'
abbr -a grm 'git rm'
abbr -a grmc 'git rm --cached'
abbr -a groh 'git reset --hard @{upstream}'
abbr -a grs 'git reset --soft'
abbr -a grv 'git remote -v'
abbr -a gs 'git status --short --branch'
abbr -a gsta 'git stash --include-untracked'
abbr -a gstk 'git stash --keep-index'
abbr -a gstl 'git stash list'
abbr -a gstp 'git stash pop'
abbr -a gsw 'git switch'
abbr -a gswc 'git switch -c'
abbr -a gwta 'git worktree add'
abbr -a gwtl 'git worktree list'
abbr -a gwtrm 'git worktree remove'

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
