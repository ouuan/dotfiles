#!/bin/bash

# paru uses Git to check devel updates, I use ssh for Git, and ssh needs confirmation
# Without this wrapper, I'll get tons of confirmation windows when paru is chekcing for devel updates

set -euo pipefail

pattern='-S(y*uy*)?a?(\s|$)'
if [[ $# == 0 || "$*" =~ $pattern ]]; then
    ssh-agent bash -c "ssh-add && paru $*"
else
    paru "$@"
fi
