_yadm() {
    if [[ "$1" == "git" ]]; then
        yadm "${@:2}"
    elif [[ "$1" == "tig" ]]; then
        tig -C "$HOME/.local/share/yadm/repo.git" "${@:2}"
    else
        yadm "$@"
    fi
}

alias y='_yadm '
alias setencrypt='$EDITOR $HOME/.config/yadm/encrypt'
alias setboot='$EDITOR $HOME/.config/yadm/bootstrap'
alias setstatus='$EDITOR ~/status/update.sh'
alias setetc='$EDITOR ~/status/etc.list'

_yadm_pub() {
    if [[ "$1" == "git" ]]; then
        yadm -Y "$HOME/.config/yadm-pub" --yadm-repo "$HOME/GitHub/dotfiles" "${@:2}"
    elif [[ "$1" == "tig" ]]; then
        tig -C "$HOME/GitHub/dotfiles" "${@:2}"
    else
        yadm -Y "$HOME/.config/yadm-pub" --yadm-repo "$HOME/GitHub/dotfiles" "$@"
    fi
}

alias yp='_yadm_pub '

upconf() {
    "$HOME/status/update.sh" && \
    y gau && \
    y gst && \
    read && \
    y gdca && \
    confirm "Continue?" && \
    yadm encrypt && \
    y gcam "Update at $(datetime)" && \
    y gp && \
    yp gau && \
    yp gst && \
    read && \
    yp gdca && \
    confirm "PUBLIC!!! Continue?" && \
    yp gcam "Update at $(datetime)" && \
    yp gp && \
    true
}
