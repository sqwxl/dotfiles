function fish_title
    set -q argv[1]; or set argv fish
    echo (fish_prompt_pwd_full_dirs=3 prompt_pwd) $argv
end
