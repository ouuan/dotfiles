export CC=/usr/lib/ccache/bin/gcc
export CXX=/usr/lib/ccache/bin/g++
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://repo.archlinuxcn.org"
export DIFFPROG='nvim -d'
export EDITOR="/usr/bin/nvim"
export FZF_DEFAULT_COMMAND='fd -H --type f -E .git'
export MANPAGER='nvim "+call ManPager()"'
export MANWIDTH=80
export PNPM_HOME="$HOME/.local/share/pnpm"
export PYENV_ROOT="$HOME/.pyenv"
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
export SCCACHE_CACHE_SIZE=4G
export WAKATIME_HOME="$HOME/.local/share/wakatime"

path=(
    "$HOME/.cargo/bin"
    "$PYENV_ROOT/bin"
    "$PNPM_HOME"
    "$HOME/.local/bin"
    "${path[@]}"
)
export PATH
