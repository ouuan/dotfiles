alias setvim='vim "+cd ~/.config/nvim/user-config" ~/.config/nvim/user-config/init.vim'
alias vim='nvim'
alias vi='nvim'
alias v.='vim "+let g:confirm_quit = 1" +Files'
alias vimupg='sshrun nvim +PlugClean +PlugConfigClean +PlugUpdate'

vimplug() {
    local repo=$(echo "$1" | rev | cut -d/ -f-2 | rev)
    local plug=$(echo "$repo" | cut -d/ -f2)
    local branch=''
    [[ "$2" != "" ]] && branch=", { 'branch': '$2' }"
    echo $branch
    perl -i -p0e "s;\ncall plug#end\(\);Plug '$repo'$branch\n\ncall plug#end();" ~/.config/nvim/user-config/init.vim
    nvim +PlugInstall +bd '+e ~/.config/nvim/user-config/init.vim' '+cd ~/.config/nvim/user-config' "+PlugConfigEdit '$plug'"
}
