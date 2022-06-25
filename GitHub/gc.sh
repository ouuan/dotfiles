#!/bin/bash

set -euo pipefail

origin_size="$(du -s | cut -f1)"

for i in */; do
    pushd "$i"
    if git rev-parse; then
        git gc
        git submodule foreach --recursive git gc
    fi
    popd
done

current_size="$(du -s | cut -f1)"

echo "
Origin:  $origin_size
Current: $current_size
Saved:   $((origin_size - current_size))"
