set -g theme_nerd_fonts yes
set -g theme_display_date no
set -g theme_newline_cursor yes
set -g theme_newline_prompt '> '
set -g theme_display_nix no
set -g theme_show_exit_status no
set -g theme_color_scheme dracula

set -gx EDITOR /usr/bin/nvim
set -gx VISUAL /usr/bin/nvim
set -gx MANPAGER '/usr/bin/nvim +Man!'

abbr -ag sdu 'sudo dnf upgrade'

abbr -ag n nvim
abbr -ag se sudoedit

abbr -ag o xdg-open

abbr -ag c clear

# alias docker podman
abbr -ag dc docker-compose

abbr -ag g git
abbr -ag ga 'git add'
abbr -ag gs 'git status'
abbr -ag gsw 'git switch'
abbr -ag gca 'git commit -a'
abbr -ag gp 'git push'

abbr -ag cfgi3 'nvim ~/.config/i3/config'
abbr -ag cfgvim 'nvim ~/.config/nvim/init.vim'
abbr -ag cfgfish 'nvim ~/.config/fish/config.fish'
abbr -ag cfgtmux 'nvim ~/.tmux.conf'
abbr -ag cfgatty 'nvim ~/.alacritty.yml'

abbr -ag rmr 'rm -rf'

# config abbr for dotfiles
abbr -ag config "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias cat bat

abbr -ag exa exa --group-directories-first
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

set -gx ANDROID_SDK $HOME/Android/Sdk
set -gx ANDROID_HOME $HOME/Android/Sdk

fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/tools/bin
fish_add_path $ANDROID_HOME/platform-tools

direnv hook fish | source
