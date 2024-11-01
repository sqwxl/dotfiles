function fish_greeting
    set -l day (date +%j)

    if not set -q last_day
        set -U last_day -1
    end

    if test $day = $last_day
        return
    end

    set last_day $day

    set_color brwhite
    echo "Greetings, Nicolas!"

    if type -q chezmoi
        chezmoi update
    end

    set_color yellow
    echo -e "The date is $(date +%A,\ %B\ %d\ %Y)\n\n"
    set_color normal

    xkcd
end
