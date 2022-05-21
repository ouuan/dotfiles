export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

clear

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx &>~/.xlog
fi
