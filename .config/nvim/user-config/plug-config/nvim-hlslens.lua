require'hlslens'.setup()

local opts = { noremap = true, silent = true }

vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
-- https://github.com/kevinhwang91/nvim-hlslens/issues/64
vim.keymap.set('n', '*', [[<Plug>(asterisk-*)<Cmd>lua require'hlslens'.start()<CR>]], opts)
vim.keymap.set('n', '#', [[<Plug>(asterisk-#)<Cmd>lua require'hlslens'.start()<CR>]], opts)
vim.keymap.set('n', 'g*', [[<Plug>(asterisk-g*)<Cmd>lua require'hlslens'.start()<CR>]], opts)
vim.keymap.set('n', 'g#', [[<Plug>(asterisk-g#)<Cmd>lua require'hlslens'.start()<CR>]], opts)
