function git_commit_safe_amend
    # check if we're in a merge
    if not set -l op (git_check_merge_op)
        command git $argv
        return
    end

    read -P "Warning: You're resolving a merge conflict. Are you sure you want to amend? [y/N]: " confirm
    if string match -qir '^y$' $confirm
        command git $argv
        return
    end

    set -l cmd
    switch $op
        case rebase
            set cmd "git rebase --continue"
        case cherry-pick
            set cmd "git cherry-pick --continue"
        case merge
            set cmd "git merge --continue"
        case '*'
            echo "Unknown merge operation: $op"
            return 1
    end

    read -P "Run `$cmd` instead? [y/N]: " confirm
    if string match -qir '^y$' $confirm
        eval $cmd
        return
    end

    echo "Aborted amending commit."
end

function git_check_merge_op
    if not test -e (git rev-parse --git-path MERGE_MSG)
        return 1
    end

    if test -d (git rev-parse --git-path rebase-apply) || test -d (git rev-parse --git-path rebase-merge)
        echo rebase
    else if test -e (git rev-parse --git-path CHERRY_PICK_HEAD)
        echo cherry-pick
    else if test -e (git rev-parse --git-path MERGE_HEAD)
        echo merge
    end
end
