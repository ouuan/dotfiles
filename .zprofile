ssh_auto_sock_path="/tmp/ssh-auto-sock-$(whoami)"
if [[ ! -S "$ssh_auto_sock_path" ]]; then
  eval $(ssh-agent)
  ln -sf "$SSH_AUTH_SOCK" "$ssh_auto_sock_path"
fi
export SSH_AUTH_SOCK="$ssh_auto_sock_path"
ssh-add -l 2>&1 >/dev/null || ssh-add

clear

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx &>~/.xlog
fi
