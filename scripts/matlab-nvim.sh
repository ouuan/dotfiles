#!/bin/bash

set -euo pipefail

unset LD_LIBRARY_PATH

NVIM_LISTEN_ADDRESS=/tmp/matlab-nvim.pipe

if [[ ! -e $NVIM_LISTEN_ADDRESS ]]; then
    konsole --name "matlab-nvim" -e nvim --listen $NVIM_LISTEN_ADDRESS "$1" &
else
    nvim --server $NVIM_LISTEN_ADDRESS --remote "$1"
    i3-msg '[instance="matlab-nvim"] focus'
fi

sleep 3
nvim --server $NVIM_LISTEN_ADDRESS --remote-send '<C-\><C-N>:ProjectRoot<CR>'
