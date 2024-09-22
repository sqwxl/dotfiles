function git
    if test $argv[1] = commit; and contains -- --amend $argv
        git_commit_safe_amend $argv
    else
        command git $argv
    end
end
