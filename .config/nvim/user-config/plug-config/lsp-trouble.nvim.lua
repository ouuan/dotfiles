require 'trouble'.setup {
  auto_close = true,
  focus = true,
}

vim.keymap.set('n', '<leader>x', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>')
vim.keymap.set('n', '<leader>X', '<cmd>Trouble diagnostics toggle<cr>')
