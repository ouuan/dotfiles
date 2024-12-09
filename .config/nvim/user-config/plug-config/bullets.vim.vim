" disable the <leader>x mapping which conflicts with Trouble
let g:bullets_set_mappings = 0
let g:bullets_custom_mappings = [
  \ ['imap', '<CR>', '<Plug>(bullets-newline)'],
  \ ['nmap', 'o', '<Plug>(bullets-newline)'],
  \ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
  \ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
  \ ['nmap', '>>', '<Plug>(bullets-demote)'],
  \ ['vmap', '>', '<Plug>(bullets-demote)'],
  \ ['nmap', '<<', '<Plug>(bullets-promote)'],
  \ ['vmap', '<', '<Plug>(bullets-promote)']
\ ]
