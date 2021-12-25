set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx MANPAGER '/usr/bin/nvim +Man!'

abbr -ag sdu 'sudo dnf upgrade'

abbr -ag n nvim
abbr -ag se sudoedit

abbr -ag o xdg-open

# alias docker podman
abbr -ag dc docker-compose

abbr -ag g git
abbr -ag ga 'git add'
abbr -ag gs 'git status'
abbr -ag gsw 'git switch'
abbr -ag gca 'git commit -a'
abbr -ag gp 'git push'

abbr -ag cfgi3 'nvim ~/.config/i3/config'
abbr -ag cfgsway 'nvim ~/.config/sway/config'
abbr -ag cfgvim 'nvim ~/.config/nvim/init.vim'
abbr -ag cfgfish 'nvim ~/.config/fish/config.fish'
abbr -ag cfgtmux 'nvim ~/.tmux.conf'
# abbr -ag cfgterm 'nvim ~/.alacritty.yml'
abbr -ag cfgterm 'nvim ~/.config/kitty/kitty.conf'

abbr -ag rmr 'rm -rf'

# config abbr for dotfiles
abbr -ag cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if command -v bat > /dev/null
  alias cat bat
end

if command -v lsd > /dev/null
  abbr -ag l 'lsd'
  abbr -ag ls 'lsd'
  abbr -ag ll 'lsd -l'
  abbr -ag lll 'lsd -lah'
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
fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/.cargo/bin

# set -gx ANDROID_SDK $HOME/Android/Sdk
# set -gx ANDROID_HOME $HOME/Android/Sdk

# fish_add_path $ANDROID_HOME/emulator
# fish_add_path $ANDROID_HOME/tools
# fish_add_path $ANDROID_HOME/tools/bin
# fish_add_path $ANDROID_HOME/platform-tools

# direnv hook fish | source

