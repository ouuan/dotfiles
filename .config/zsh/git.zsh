alias gh='setsocks5 gh'

alias gbro='gh browse'
alias gci='gh run watch'
alias gcm='gco $(git_main_branch)'
alias gco='gcor'
alias gdch='git diff --color-words=.'
alias gfu='gf upstream'
alias gi='gh issue list'
alias grst='gaa && grhh && gst -s | cut -c 4- | xargs -n 1 trash; gsuir'
alias gsuir='gsu --init --recursive'
alias gupd='gaa && gcam "Update at $(date "+%Y-%m-%d %H:%M:%S")"'
alias gsd='g -c core.pager="git-split-diffs --color | less -RFX" diff'

unalias gstaa # use gstp instead

alias gbl='tig blame'
alias glg='tig log'
alias glo='tig'
alias greflog='tig reflog'
alias gsh='tig show'

function git() {
    if [[ "$1" =~ "^(clone|fetch|lfs|pull|push)$" && "$@" != *"-h"* ]]; then
        sshrun /usr/bin/git "$@"
    else
        /usr/bin/git "$@"
    fi
}

GIT_MAIN_BRANCH_PRIORITY="hugo:master:main:dev:masterk"

# override the function in the git plugin
function git_main_branch() {
  [[ -v GIT_MAIN_BRANCH_PRIORITY ]] || GIT_MAIN_BRANCH_PRIORITY="master:main"
  local git_main_branch_array=("${(@s/:/)GIT_MAIN_BRANCH_PRIORITY}")
  local git_branch_list="$(git for-each-ref --format='%(refname:short)' refs/heads/*)"
  local git_branch_array=("${(f)git_branch_list}")

  for branch in $git_main_branch_array; do
    if (($git_branch_array[(Ie)$branch])); then
      echo "$branch"
      return 0
    fi
  done

  echo master
  return 1
}

ghcl() {
    cd "$HOME/GitHub"
    gh repo clone "$1" -- --recurse-submodules "${@:2}"
    cd "$(echo "$1" | rev | cut -d/ -f1 | rev)"
}

gcpr () {
    gco "pr-$1" >/dev/null 2>&1 || gh pr checkout "$1" -b "pr-$1"
}

grau () {
    [[ "$1" == "" ]] && echo "grau <upstream repo owner>" || gra upstream $(sed "s/\.com:[^\/]\+/.com:$1/" <(gr get-url origin))
}

grouuan() {
    gr get-url origin >/dev/null 2>&1 && { gra upstream $(gr get-url origin) && grrm origin } || true
    gra origin git@github.com:ouuan/$(basename $(pwd))
}
