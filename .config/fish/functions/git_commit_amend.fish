function git_commit_amend
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        # check if we're in a merge
        if test -s (git rev-parse --git-path MERGE_MSG)
            read -P "Warning: You're resolving a merge conflict. Are you sure you want to amend? [y/N]: " confirm
            if not test $confirm = y
                set -l op (check_git_operation)
                set -l cmd
                if test $op = rebase
                    set cmd "git rebase --continue"
                else if test $op = cherry-pick
                    set cmd "git cherry-pick --continue"
                else if test $op = merge
                    set cmd "git merge --continue"
                end

                read -P "Run `$cmd` instead? [Y/n]: " confirm
                if not test $confirm = n
                    eval $cmd
                end
                return
            end
        end
    end
    command git commit --amend $argv
end

function check_git_operation
    if test -d .git/rebase-apply || test -d .git/rebase-merge
        echo rebase
        return
    end

    if test -f .git/CHERRY_PICK_HEAD
        echo cherry-pick
        return
    end

    if test -f .git/MERGE_HEAD && test -f .git/MERGE_MODE && test -f .git/MERGE_MSG
        echo merge
        return
    end

    echo other
end
