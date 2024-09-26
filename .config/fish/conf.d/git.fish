abbr -a g git

alias cfginit "git init --bare $HOME/.dotfiles && git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME remote add origin && echo .dotfiles >> $HOME/.gitignore"
alias cfg "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gau 'git add --update'
abbr -a gap 'git add --patch'
abbr -a gai 'git add --interactive'

abbr -a grm 'git rm'
abbr -a grmc 'git rm --cached'

abbr -a gC 'git clean --interactive -d'
abbr -a gCf 'git clean --interactive -d --force'

abbr -a gr 'git reset'
abbr -a grh 'git reset --hard'
abbr -a groh 'git reset --hard @{upstream}'
abbr -a grk 'git reset --keep'
abbr -a grs 'git reset --soft'

abbr -a grt 'git restore'
abbr -a grts 'git restore --staged'

abbr -a gc 'git commit'
abbr -a gca 'git commit --all'
abbr -a gcm 'git commit --message'
abbr -a gcam 'git commit -all --message'
abbr -a gcan 'git commit --amend --no-edit'
abbr -a gcann 'git commit --amend --no-edit --no-verify'
abbr -a gcana 'git commit --amend --no-edit --all'
abbr -a gcanan 'git commit --amend --no-edit --all --no-verify'
abbr -a gfu 'git commit --fixup && git rebase -i --autosquash'

abbr -a grb 'git rebase'
abbr -a grbi 'git rebase --interactive'
abbr -a gi 'git rebase --interactive'
abbr -a grbI 'git rebase --interactive --autostash'
abbr -a gI 'git rebase --interactive --autostash'
abbr -a grba 'git rebase --abort'
abbr -a grbc 'git rebase --continue'
abbr -a grbe 'git rebase --edit-todo'

abbr -a gcp 'git cherry-pick'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gcpa 'git cherry-pick --abort'

abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmc 'git merge --continue'
abbr -a gmt 'git mergetool'
abbr -a gmtg 'git mergetool --gui'

abbr -a grv 'git remote -v'
abbr -a gf 'git fetch'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gpl 'git pull'
abbr -a gplr 'git pull --rebase'

abbr -a gb 'git branch'
abbr -a gba 'git branch --all'

abbr -a gco 'git checkout'
abbr -a gcop 'git checkout --patch'
abbr -a gsw 'git switch'
abbr -a gswc 'git switch -c'

abbr -a gl 'git log --decorate --pretty=oneline --abbrev-commit'
abbr -a glm 'git log --decorate --pretty=oneline --abbrev-commit origin/main^..'
abbr -a gll 'git log --graph --decorate --pretty=oneline --abbrev-commit'
abbr -a glll 'git log --graph --decorate --pretty=oneline --abbrev-commit --all'
abbr -a gsh 'git show'
abbr -a gsn 'git show --name-only'
abbr -a grl 'git reflog'

abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gdup 'git diff @\{upstream\}'
abbr -a gs 'git status --short --branch'
abbr -a gss 'git status'

abbr -a gS 'git stash'
abbr -a gSD 'git stash drop'
abbr -a gSa 'git stash --include-untracked'
abbr -a gSk 'git stash --keep-index'
abbr -a gSl 'git stash list'
abbr -a gSp 'git stash pop'
abbr -a gSs 'git stash show --patch'

abbr -a gwa 'git worktree add'
abbr -a gwl 'git worktree list'
abbr -a gwd 'git worktree remove'

if type -q git-forgit
    abbr -a ga 'git forgit add'
    abbr -a gd 'git forgit diff'
    abbr -a gco 'git forgit checkout'
    abbr -a gcp 'git forgit cherry-pick'
    abbr -a grb 'git forgit rebase'
end
