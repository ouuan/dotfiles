#!/bin/bash

set -eu

dunst_paused=$(dunstctl is-paused)
dunstctl set-paused true

i3-msg workspace "l$(pwgen -s 10 1)"
i3-msg bar mode invisible buttons

i3lock \
    -i "$HOME/Pictures/arch.png" \
    --ind-pos w/2:h/2-35 \
    --greeter-text="Yufan You" \
    --greeter-size=30 \
    --greeter-color=ffffff66 \
    --clock \
    --date-font "Noto Sans CJK SC" \
    --date-str "%Y/%m/%d (%a)" \
    --date-size=18 \
    --date-color=ffffff66 \
    --time-str "%H:%M" \
    --time-size=50 \
    --time-pos "ix:iy+200" \
    --time-color=ffffff66 \
    --pass-media-key \
    --nofork

i3-msg bar mode hide buttons

dunstctl set-paused $dunst_paused
