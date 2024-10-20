function fish_remove_path
    if set -l idx (contains -i -- $argv[1] $fish_user_paths)
        set -e fish_user_paths[$idx]
    end
end
