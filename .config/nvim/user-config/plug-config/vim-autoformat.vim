nmap <leader>f <cmd>Autoformat<cr>
" let g:format_on_save_list  = ['cpp']
" " let g:autoformat = 0/1 to set auto-format or not
" au BufWrite * if get(g:, 'autoformat', index(g:format_on_save_list, &ft) < 0 ? 0 : 1) == 1 | :Autoformat

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

let g:formatters_python = ['black']
