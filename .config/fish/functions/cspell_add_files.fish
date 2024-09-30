function cspell_add_files
    if test (count $argv) -eq 0
        echo "Usage: cspell_add_files FILE..."
        return 1
    end

    set -f config $HOME/.config/cspell/cspell.yaml
    set -f dictionary $HOME/.config/cspell/custom.txt
    set -f words (cspell -c $config --words-only --unique --no-progress --no-summary $argv)

    echo $words
    printf %s\n $words >>$dictionary
end
