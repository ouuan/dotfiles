#!/bin/bash

original="$(xclip -o)"
translated="$(trans -b "$original")"

if [[ $(echo "$original" | wc -w) == 1 && $(echo "$original" | wc -c) -lt 20 ]]; then
    url="https://fanyi.baidu.com/#auto/auto/$original"
    notify-send "翻译" "$original: $translated

$url"
else
    url="https://translate.google.com/?sl=auto&tl=zh-CN&text=$(jq -rn --arg x "$original" '$x|@uri')"
    notify-send "翻译" "
$original

$translated


$url"
fi
