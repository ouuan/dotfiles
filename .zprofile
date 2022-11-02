export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export INPUT_METHOD=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS='@im=fcitx'

export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_USE_PORTAL=1

export WAKATIME_HOME="$HOME/.local/share/wakatime"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org https://repo.archlinuxcn.org"
export SCCACHE_CACHE_SIZE=1G

clear

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx &>~/.xlog
fi
