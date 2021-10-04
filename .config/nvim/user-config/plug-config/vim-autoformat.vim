nmap <leader>f :Autoformat<cr>
let g:format_on_save_list  = ['cpp']
" let b:autoformat = 0/1 to set auto-format or not
au BufWrite * if get(b:, 'autoformat', index(g:format_on_save_list, &ft) < 0 ? 0 : 1) == 1 | :Autoformat

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
