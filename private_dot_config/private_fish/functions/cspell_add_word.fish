function cspell_add_word
    if test (count $argv) -ne 1
        echo "Usage: cspell_add_word WORD"
        return 1
    end

    set -f config $HOME/.config/cspell/cspell.yaml
    set -f dictionary $HOME/.config/cspell/custom.txt

    echo $argv[1] >>$dictionary
end
