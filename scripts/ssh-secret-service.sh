#!/bin/bash

set -euo pipefail

pa="$(ps -o args= $PPID)"
key="$(echo "$*" | sed "s/^.*[' ]\\(\\/.*\\.ssh[^':]*\\).*$/\\1/")"
kdialog --yesno "Allow
$pa
to use
$key
?"
secret-tool lookup ssh-key "$key" || kdialog --password "$*"
