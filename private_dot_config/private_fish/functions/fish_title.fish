function fish_title
    set -q argv[1]; or set argv fish
    
    set branch

    git rev-parse --is-inside-worktree &>/dev/null; and set branch (git branch --show-current)
    echo $argv (fish_prompt_pwd_full_dirs=3 prompt_pwd)(set -q branch; and echo " - $branch")
end
