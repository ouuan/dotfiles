#!/bin/bash

set -euo pipefail

for i in */; do
    pushd "$i"
    if git rev-parse; then
        git gc
        git submodule foreach --recursive git gc
    fi
    popd
done
