#!/bin/bash

# X.Org 任意窗口划词翻译
# 在 DE/WM 中设置快捷键执行
# 分单词和句子两种模式，notification 中显示的都是 Google 翻译的结果，但单词附带百度翻译的链接，句子附带 Google 翻译的链接
# notification 中附带的链接是否能点开依赖于 notification daemon，dunst 需要在设置中的 `mouse_left_click` 处加上 `open_url`
# 翻译的单词连同日期和窗口标题会记录在 ~/.cache/translated-words.txt
# 可以使用 http_proxy 环境变量设置代理
# notification 的 appname 是 "xorg-translate"，在 dunst 中可以对其进行配置，例如设置图标
#
# dependencies: xclip, translate-shell, jq, xdotool, libnotify 以及任意 notification daemon（例如你的桌面环境自带的或者 dunst）
#
# Hosted at https://gist.github.com/ouuan/909f25f18a74d9e04e1e0881d3316905

#  Copyright 2022-2024 Yufan You
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0

set -euo pipefail

original="${*:-$(xclip -o)}"
if [[ $(echo "$original" | wc -w) == 1 && ${#original} -lt 20 ]]; then
    is_word=true
    original="$(echo "$original" | sed 's/^[[:punct:]]//g;s/[[:punct:]]$//g')"
    url="https://oalecd10.cp.com.cn/#/desktop/dict/search-result/$original"
else
    is_word=false
    url="https://translate.google.com/?sl=auto&tl=zh-CN&text=$(jq -rn --arg x "$original" '$x|@uri')"
fi

if [ -z ${http_proxy+x} ]; then
    proxy=()
else
    proxy=(-x "$http_proxy")
fi

pending="$(notify-send -a xorg-translate -p -u low "翻译" "正在翻译，请稍候...\n\n$original")"

notify() {
    notify-send -a xorg-translate -r "$pending" "翻译" "$@"
}

translated="$(trans -e google -t zh-CN "${proxy[@]}" -b "$original" || ( notify "[ERROR] 翻译出错，请重试

$url" && false ))"

if [[ $is_word == true ]]; then
    printf "%-30s$(date '+%Y/%m/%d %H:%M')    $(xdotool getwindowname "$(xdotool getactivewindow)")\n" "$original" >> ~/.cache/translated-words.txt
    notify -t 8000 "$original: $translated

$url"
else
    notify -t $(( ${#translated} * 200 + 8000 )) "
$translated

$original


$url"
fi
