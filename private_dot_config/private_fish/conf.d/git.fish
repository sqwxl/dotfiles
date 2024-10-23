abbr g git
abbr gg gitui

abbr ga 'git add'
abbr gaa 'git add --all'
abbr gau 'git add --update'
abbr gap 'git add --patch'
abbr gai 'git add --interactive'

abbr grm 'git rm'
abbr grmc 'git rm --cached'

abbr gC 'git clean --interactive -d'
abbr gCf 'git clean --interactive -d --force'

abbr gr 'git reset'
abbr grh 'git reset --hard'
abbr groh 'git reset --hard @{upstream}'
abbr grk 'git reset --keep'
abbr grs 'git reset --soft'

abbr grt 'git restore'
abbr grts 'git restore --staged'

abbr gc 'git commit'
abbr gca 'git commit --all'
abbr gcm 'git commit --message'
abbr gcam 'git commit -all --message'
abbr gcan 'git commit --amend --no-edit'
abbr gcann 'git commit --amend --no-edit --no-verify'
abbr gcana 'git commit --amend --no-edit --all'
abbr gcanan 'git commit --amend --no-edit --all --no-verify'
abbr gfu 'git commit --fixup && git rebase -i --autosquash'

abbr grb 'git rebase'
abbr grbi 'git rebase --interactive'
abbr gi 'git rebase --interactive'
abbr grbI 'git rebase --interactive --autostash'
abbr gI 'git rebase --interactive --autostash'
abbr grba 'git rebase --abort'
abbr grbc 'git rebase --continue'
abbr grbe 'git rebase --edit-todo'

abbr gcp 'git cherry-pick'
abbr gcpc 'git cherry-pick --continue'
abbr gcpa 'git cherry-pick --abort'

abbr gm 'git merge'
abbr gma 'git merge --abort'
abbr gmc 'git merge --continue'
abbr gmt 'git mergetool'
abbr gmtg 'git mergetool --gui'

abbr grv 'git remote -v'
abbr gf 'git fetch'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpfm 'git push --force-with-lease origin HEAD:sqwxl/main'
abbr gpl 'git pull'
abbr gplr 'git pull --rebase'

abbr gb 'git branch'
abbr gba 'git branch --all'

abbr gco 'git checkout'
abbr gcop 'git checkout --patch'
abbr gsw 'git switch'
abbr gswc 'git switch -c'

abbr gl 'git log --decorate --pretty=oneline --abbrev-commit'
abbr glm --set-cursor 'git log --decorate --pretty=oneline --abbrev-commit origin/main^..%'
abbr glmm 'git log --decorate --pretty=oneline --abbrev-commit origin/main^..main'
abbr gll 'git log --graph --decorate --pretty=oneline --abbrev-commit'
abbr glll 'git log --graph --decorate --pretty=oneline --abbrev-commit --all'
abbr gsh 'git show'
abbr gsn 'git show --name-only'
abbr grl 'git reflog'

abbr gd 'git diff'
abbr gds 'git diff --staged'
abbr gdup 'git diff @\{upstream\}'
abbr gs 'git status --short --branch'
abbr gss 'git status'

abbr gS 'git stash'
abbr gSD 'git stash drop'
abbr gSa 'git stash --include-untracked'
abbr gSk 'git stash --keep-index'
abbr gSl 'git stash list'
abbr gSp 'git stash pop'
abbr gSs 'git stash show --patch'

abbr gwa 'git worktree add'
abbr gwl 'git worktree list'
abbr gwd 'git worktree remove'

abbr sprr 'spr diff -m Rebase'
abbr spru 'spr diff -m Update'

if type -q git-forgit
    abbr ga 'git forgit add'
    abbr gd 'git forgit diff'
    abbr gco 'git forgit checkout'
    abbr gcp 'git forgit cherry-pick'
    abbr grb 'git forgit rebase'
end
