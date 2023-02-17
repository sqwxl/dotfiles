set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER less

abbr -ag n nvim
abbr -ag s sudo
abbr -ag se sudoedit

abbr -ag o xdg-open

# alias docker podman
abbr -ag dc docker-compose

abbr -ag g git
abbr -ag gs 'git status'
abbr -ag gd 'git diff'
abbr -ag gds 'git diff --staged'
abbr -ag gw 'git switch'
abbr -ag gl 'git log --oneline'
abbr -ag gll 'git log'
abbr -ag grl 'git reflog'
abbr -ag ga 'git add'
abbr -ag gaa 'git add .'
abbr -ag gcm 'git commit -m'
abbr -ag gcam 'git commit -a -m'
abbr -ag gcan 'git commit --amend --no-edit'
abbr -ag gp 'git push'
abbr -ag gpu 'git push -u origin'
abbr -ag gpf 'git push -f'
abbr -ag gr 'git remote -v'
abbr -ag gb 'git branch'

abbr -ag cfgsway 'cd ~/.config/sway && nvim config'
abbr -ag cfgvim 'cd ~/.config/nvim && nvim init.lua'
abbr -ag cfgfish 'cd ~/.config/fish && nvim config.fish'
abbr -ag cfgterm 'cd ~/.config/kitty && nvim kitty.conf'
abbr -ag cfgterm 'nvim ~/.config/kitty/kitty.conf'

abbr -ag rmr 'rm -rf'

# config abbr for dotfiles
alias cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

abbr -ag myip "curl -4 icanhazip.com"

if type -q bat
  alias cat bat
end
if type -q batcat
  alias cat batcat
  alias bat batcat
end

if type -q exa
  abbr -ag l 'exa'
  abbr -ag ll 'exa -l'
  abbr -ag lll 'exa -la'
  alias ls exa
else if type -q lsd
  abbr -ag l 'lsd'
  abbr -ag ll 'lsd -l'
  abbr -ag lll 'lsd -lah'
  alias ls lsd
else
  abbr -ag l 'ls'
  abbr -ag ll 'ls -l'
  abbr -ag lll 'ls -lah'
end

if type -q rg
  set -gx FZF_DEFAULT_COMMAND rg --files
  set -gx FZF_DEFAULT_OPTS -m
end

if type -q go
  fish_add_path (go env GOPATH)/bin
end

if type -q node
  fish_add_path $HOME/.npm-global/bin
end

if type -q rustup
  fish_add_path $HOME/.cargo/bin
  # alias rust-analyzer 'rustup run stable rust-analyzer'
end

if type -q fdfind
  alias fd fdfind
end

if type -q zoxide
  zoxide init fish | source
end

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

complete -c cht.sh -xa '(curl -s cht.sh/:list)'

if type -q starship
  starship init fish | source
end

if type -q direnv
  direnv hook fish | source
end

if type -q bit
  fish_add_path $HOME/bin
end

source "$HOME/.config/fish/functions/__auto_source_venv.fish"
