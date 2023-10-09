# new setup

```fish
git init --bare $HOME/.dotfiles
echo 'alias cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"' >> $HOME/.config/fish/config.fish
source $HOME/.config/fish/config.fish
cfg config --local status.showUntrackedFiles no
```

# clone on new system

```fish
git clone --bare https://github.com/sqwxl/dotfiles.git $HOME/.dotfiles

echo 'alias cfg "git --git-dir=$HOME/.dotfiles--work-tree=$HOME"' >> $HOME/.config/fish/config.fish
source $HOME/.config/fish/config.fish

cfg checkout
if test $status -ne 0
  echo "Backing up pre-existing dotfiles to .config-backup"
  mkdir -p .config-backup
  cfg checkout 2>&1 | grep -E "\s+\." | string trim | xargs -I{} fish -c "cp --parents {} .config-backup/ && rm -rf {}"
  cfg checkout
end
cfg config --local status.showUntrackedFiles no
```
