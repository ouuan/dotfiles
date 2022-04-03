#!/bin/bash

# In <duration> seconds, if you have been unlocked for more than <permit> seconds, you'll be locked;
# if you have been unlocked for more than <warning> seconds, you'll be asked to lock every <dialoginterval> seconds.
# The stats are saved at <file>.

duration=9000
permit=8500
warning=7800
dialoginterval=60
file="/tmp/take-a-break-stats"

# depends:
# -   kdialog
# -   systemd logind
# -   locker program
#     -   i3-wm users:
#         -   https://github.com/xdbob/xss-lock/tree/locked_hint (https://aur.archlinux.org/packages/xss-lock-locked-hint/)
#         -   add `exec --no-startup-id xss-lock --transfer-sleep-lock -- <your lock program such as i3lock>` in your i3 config
#     -   other DE/WM users:
#         I'm not sure, but you need a screen locker that changes the `LockedHint` property of systemd logind.
#         Maybe your DE already supports it but I don't know.

# Copyright 2021 Yufan You
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0

set -euo pipefail

lastdialog=0

touch "$file"

while true
do
    now=$(date +%s)

    while [[ $(wc -l < "$file") -gt 0 ]] && [[ $(head -n1 "$file") -lt $(( now - duration )) ]]
    do
        sed -i '1d' "$file"
    done

    used=$(wc -l < "$file")

    if [[ $(loginctl show-session self -p LockedHint --value) == 'no' ]]
    then
        echo "$now" >> "$file"
        if [[ "$used" -gt "$permit" ]]
        then
            kdialog --msgbox "TAKE A BREAK RIGHT NOW!!!" --title "Take A Break" &
            sleep 3s
            loginctl lock-session self
            kill "$!" || true
        elif [[ "$used" -gt "$warning" ]] && [[ "$now" -gt $(( lastdialog + dialoginterval )) ]]
        then
            ( kdialog --warningyesno "You need to take a break!\nLock screen now?" --yes-label "Lock (&Y)" --no-label "Wait a minute (&N)" --title "Take A Break" \
                && loginctl lock-session self || true ) &
            lastdialog="$now"
        fi
    fi

    sleep 1s
done
