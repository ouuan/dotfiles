let g:vimtex_compiler_latexmk_engines = { '_' : '-xelatex' }

let g:vimtex_compiler_latexmk = {
    \ 'options': [
        \ '-shell-escape'
    \ ],
\}

let g:vimtex_quickfix_ignore_filters = [
    \ 'Font shape',
    \ 'Token not allowed in a PDF string',
\]

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
