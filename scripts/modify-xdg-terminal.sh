#!/bin/bash

mkdir -p "$HOME/.local/share/applications"
cd /usr
rg 'Terminal=true' share/applications -l | xargs -i bash -c "sed '/^Terminal=/d;s/^Exec=/Exec=konsole -e /' /usr/{} > ~/.local/{}"
