au FileType tex nmap <buffer> <leader>p <cmd>VimtexCompile<cr>
au FileType tex nmap <buffer> <cr> <cmd>VimtexView<cr>

let g:vimtex_compiler_latexmk_engines = { '_' : '-xelatex' }

let g:vimtex_quickfix_ignore_filters = [
    \ 'Font shape',
    \ 'Token not allowed in a PDF string',
    \ 'pdfTeX is not running in PDF mode',
    \ 'You are using breakurl while processing via pdflatex',
    \ 'Package microtype Warning: \\nonfrenchspacing is active.',
    \ 'most likely cause issues with the appearance of inserted todonotes',
\]

let g:vimtex_view_method = 'zathura'

augroup vimtex_clean
    au!
    au User VimtexEventQuit if get(b:, "vimtex_enabled", 1) == 1 | call vimtex#compiler#clean(0) | end
augroup END
