export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"
export PATH="$PYENV_ROOT/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PNPM_HOME="/home/ouuan/.local/share/pnpm"
[[ -e $PNPM_HOME ]] && export PATH="$PNPM_HOME:$PATH"
[[ -e $HOME/.yarn/bin ]] && export PATH="$HOME/.yarn/bin:$PATH"
[[ -e $HOME/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"

export DIFFPROG='nvim -d'
export EDITOR="/usr/bin/nvim"
export FZF_DEFAULT_COMMAND='fd -H --type f -E .git'
export MANPAGER='nvim "+call ManPager()"'
export MANWIDTH=80

export CC=/usr/lib/ccache/bin/gcc
export CXX=/usr/lib/ccache/bin/g++
export SCCACHE_CACHE_SIZE=4G
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://repo.archlinuxcn.org"

export QQ_DOWNLOAD_DIR="$HOME/Downloads/QQ"
export WAKATIME_HOME="$HOME/.local/share/wakatime"
