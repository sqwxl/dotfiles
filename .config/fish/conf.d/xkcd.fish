if not type -q magick
    exit
end
if not set -q xkcd_day
    set -U xkcd_day -1
end
set -l day (date +%j) # 0-365
if test $day != $xkcd_day
    set xkcd_day $day
    curl -s (curl -s https://xkcd.com/info.0.json | jq -r '.img') | magick png:- -border 4% sixel:-
end
