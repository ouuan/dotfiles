#!/bin/bash

# vivado-nvim.sh "[file name]" [line number]

set -euo pipefail

unset LD_LIBRARY_PATH

NVIM_LISTEN_ADDRESS=/tmp/vivado-nvim.pipe

if [[ ! -e $NVIM_LISTEN_ADDRESS ]]; then
    konsole --name "vivado-nvim" -e nvim --listen $NVIM_LISTEN_ADDRESS "$1" "+$2" &
else
    nvim --server $NVIM_LISTEN_ADDRESS --remote "$1"
    nvim --server $NVIM_LISTEN_ADDRESS --remote-send ":$2<CR>"
    i3-msg '[instance="vivado-nvim"] focus'
fi

sleep 3
nvim --server $NVIM_LISTEN_ADDRESS --remote-send '<C-\><C-N>:ProjectRoot<CR>'
