if status is-interactive
    # Commands to run in interactive sessions can go here
end

# remove default greeting
set -g fish_greeting


set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim

alias n nvim
alias ls "ls -alG --group-directories-first --color=auto"
alias config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

