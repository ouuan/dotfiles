au FileType tex nmap <buffer> <leader>p :VimtexCompile<cr>

let g:vimtex_compiler_latexmk_engines = { '_' : '-xelatex' }

let g:vimtex_compiler_latexmk = {
\ 'aux_dir' : '',
\ 'out_dir' : '',
\ 'callback' : 1,
\ 'continuous' : 1,
\ 'executable' : 'latexmk',
\ 'hooks' : [],
\ 'options' : [
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
\   '-interaction=nonstopmode',
\   '-shell-escape',
\ ],
\}

let g:vimtex_quickfix_ignore_filters = [
    \ 'Font shape',
    \ 'Token not allowed in a PDF string',
    \ 'pdfTeX is not running in PDF mode',
    \ 'You are using breakurl while processing via pdflatex',
    \ 'Package microtype Warning: \\nonfrenchspacing is active.',
    \ 'most likely cause issues with the appearance of inserted todonotes',
\]

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

augroup vimtex_clean
    au!
    au User VimtexEventQuit if get(b:, "vimtex_enabled", 1) == 1 | call vimtex#compiler#clean(0) | end
augroup END
