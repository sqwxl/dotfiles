function git
    if test $argv[1] = commit; and contains -- --amend $argv
        git_commit_safe_amend $argv
    else if test $argv[1] = switch
        set -l output (command git $argv 2>&1)
        set -l status_code $status
        set -l branch $argv[2]
        if test $status_code -ne 0; and string match -q "*already used by worktree*" "$output"
            set -l path (git worktree list | rg $branch | awk '{print $1}')
            if test -n "$path"
                cd $path
                return 0
            end
        end
        echo $output
        return $status_code
    else
        command git $argv
    end
end
