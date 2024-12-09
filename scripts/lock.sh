#!/bin/bash

set -eu

dunst_paused=$(dunstctl is-paused)
dunstctl set-paused true

i3-msg workspace "l$(pwgen -s 10 1)"
i3-msg bar mode invisible buttons

# i3lock is actually i3lock-color
i3lock \
    -i "$HOME/Pictures/arch-tall.png" -C \
    --ind-pos "x+w/2:y+h/2-35" \
    --greeter-text="Yufan You" \
    --greeter-size=30 \
    --greeter-color=ffffff66 \
    --greeter-pos "ix:iy+h/6+160" \
    --clock \
    --date-font "Noto Sans CJK SC" \
    --date-str "%Y/%m/%d (%a)" \
    --date-size=18 \
    --date-color=ffffff66 \
    --time-str "%H:%M" \
    --time-size=50 \
    --time-pos "ix:iy+h/8+100" \
    --time-color=ffffff66 \
    --pass-media-key \
    --nofork

i3-msg bar mode hide buttons

dunstctl set-paused "$dunst_paused"
