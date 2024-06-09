#!/bin/bash

# Fix "Firefox is already running" at startup when using profile-sync-daemon

set -euo pipefail

profile="$(ls -d ~/.mozilla/firefox/*.default-release)"

while [[ "$(readlink -n "$profile")" == /dev/null ]]; do
    inotifywait -P "$profile"
done

firefox &
