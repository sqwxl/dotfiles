# remove default greeting
set -g fish_greeting

set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx PAGER /usr/bin/most

abbr -ag n nvim
abbr -ag e nvim
abbr -ag se sudoedit

alias docker podman
abbr -ag dc docker-compose

abbr -ag m make

abbr -ag g git
abbr -ag ga 'git add -p'
abbr -ag gc 'git checkout'
abbr -ag gm 'git commit -m'
abbr -ag gl 'git pull'
abbr -ag gp 'git push'

abbr -ag cfgi3 'nvim ~/.config/i3/config'
abbr -ag cfgvim 'nvim ~/.vimrc'
abbr -ag cfgfish 'nvim ~/.config/fish/config.fish'
abbr -ag cfgtmux 'nvim ~/.tmux.conf'
abbr -ag cfgatty 'nvim ~/.alacritty.yml'

# config abbr for dotfiles
abbr -ag config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

abbr -ag exa exa --group-directories-first
if command -v exa > /dev/null
	abbr -ag l 'exa'
	abbr -ag ls 'exa'
	abbr -ag ll 'exa -l'
	abbr -ag lll 'exa -la'
else
	abbr -ag l 'ls'
	abbr -ag ll 'ls -l'
	abbr -ag lll 'ls -la'
end

if command -v rg > /dev/null
	set -gx FZF_DEFAULT_COMMAND rg --files
	set -gx FZF_DEFAULT_OPTS -m
end

if command -v go > /dev/null
	fish_add_path (go env GOPATH)/bin
end

fish_add_path $HOME/.local/bin
