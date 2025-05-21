nmap <leader>bL <cmd>Git blame -C<cr>

augroup fugitive_aug
    autocmd!
    autocmd FileType fugitive#BlameFileType() nmap <buffer> q <cmd>q<cr>
augroup END
