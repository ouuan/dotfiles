let g:goyo_width = 120
nmap <silent> <leader>z :noau Goyo<cr>

fun! ManGoto()
    Man
    nnoremap <buffer> q :qall<cr>
endf

fun! ManPager()
    Man!
    noau Goyo
    nnoremap <buffer> q :qall<cr>
    nnoremap <buffer> Q :qall<cr>
    nnoremap gd :call ManGoto()<cr>
endf
