command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --iglob !.git --hidden --column --line-number --no-heading --color=always --smart-case --pcre2 -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nmap <leader>o :Files<cr>
nmap <leader>/ :Rg<Space>
