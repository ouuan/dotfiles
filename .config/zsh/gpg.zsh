addencrypt() {
    local tmp=$(mktemp)
    echo "$2" >"$tmp"
    $EDITOR "$tmp" </dev/tty >/dev/tty || return 1
    gpg -o "$1.gpg" -c "$tmp"
    \rm "$tmp"
}

editencrypt() {
    addencrypt "${1%.gpg}" "$(decrypt "$1")"
}

addsecret() {
    addencrypt "$HOME/.secrets/$1" "$2"
}

decrypt() {
    if [[ -e "$1" ]]; then
        gpg -d "$1" 2>/dev/null || gpg -d "$1"
    elif [[ -e "$HOME/.secrets/$1" ]]; then
        decrypt "$HOME/.secrets/$1"
    else
        echo "decrypt: [$1] not found!"
        false
    fi
}

_decrypt() {
    compadd $(\ls)
    compadd $(\ls "$HOME/.secrets")
}
compdef _decrypt decrypt
