#!/bin/bash

set -euo pipefail

LOCK_PATH='/var/lib/pacman/db.lck'

# while [[ -e "$LOCK_PATH" ]]; do
#     sleep 1
# done

sudo flock "$LOCK_PATH" -c "touch '$LOCK_PATH' && $@ && rm '$LOCK_PATH'"
