function xkcd
    if not type -q magick
        return
    end
    curl -s https://xkcd.com/info.0.json | jq -r '.img' | xargs curl -s | magick png:- -bordercolor "#282828" -border 5% sixel:-
end
