#!/bin/bash

original="$(xclip -o)"
translated="$(trans -b "$original")"

if [[ $(echo "$original" | wc -w) == 1 && $(echo "$original" | wc -c) -lt 20 ]]; then
    printf "%-30s$(date '+%Y/%m/%d %H:%M')    $(xdotool getwindowname $(xdotool getactivewindow))\n" "$original" >> ~/.cache/translated-words.txt
    url="https://fanyi.baidu.com/#auto/zh/$original"
    notify-send -t 8000 "翻译" "$original: $translated

$url"
else
    url="https://translate.google.com/?sl=auto&tl=zh-CN&text=$(jq -rn --arg x "$original" '$x|@uri')"
    notify-send -t $(( $(echo "$translted" | wc -m) * 200 + 8000 )) "翻译" "
$original

$translated


$url"
fi
