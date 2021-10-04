eval "$(hub alias -s)"
alias gh='setsocks5 gh'

alias grst='gaa && grhh && gst -s | cut -c 4- | xargs -n 1 trash; gsu --init --recursive'
alias gdch='git diff --color-words=.'
alias gfu='gf upstream'
alias gsuir='g submodule update --init --recursive'
alias gbro='git browse --'
alias gci='gh run view'
alias gciw='gh run watch'
alias gi='gh issue list'
alias gco='gcor'
alias gcm='gco $(git_main_branch)'

alias glo='tig'
alias gsh='tig show'
alias glg='tig log'
alias gbl='tig blame'
alias greflog='tig reflog'

GIT_MAIN_BRANCH_PRIORITY="hugo:master:main:dev"

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
    gco "pr-$1" >/dev/null 2>&1 || hub pr checkout "$1" "pr-$1"
}

grau () {
    [[ "$1" == "" ]] && echo "grau <upstream repo owner>" || gra upstream $(sed "s/\.com:[^\/]\+/.com:$1/" <(gr get-url origin))
}

grouuan() {
    gr get-url origin >/dev/null 2>&1 && { gra upstream $(gr get-url origin) && grrm origin } || true
    gra origin git@github.com:ouuan/$(basename $(pwd))
}
