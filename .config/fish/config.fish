# remove default greeting
set -g fish_greeting

set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx PAGER /usr/bin/most

abbr -ag n nvim
abbr -ag e nvim
abbr -ag se sudoedit

abbr -ag ds sudo systemctl start docker
abbr -ag dc sudo docker-compose

abbr -ag m make

abbr -ag g git
abbr -ag ga 'git add -p'
abbr -ag gc 'git checkout'
abbr -ag gm 'git commit -m'
abbr -ag gl 'git pull'
abbr -ag gp 'git push'

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

fish_add_path (go env GOPATH)/bin

