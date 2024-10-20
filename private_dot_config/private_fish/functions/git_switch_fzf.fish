function git_switch_fzf
    set branch (git branch --sort=-committerdate | fzf)
    if string match -q -r '^\+' $branch
        cd (git worktree list | grep "\[$(string trim (string sub -s 2 $branch))\]" | string split ' ' -f 1)
    else
        git switch (string trim $branch)
    end
end
