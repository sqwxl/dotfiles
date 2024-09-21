function git
    if test $argv[1] = commit; and contains -- --amend $argv
        git_commit_amend $argv[2..-1]
    else
        command git $argv
    end
end
