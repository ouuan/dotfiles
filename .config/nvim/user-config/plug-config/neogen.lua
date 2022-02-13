require('neogen').setup {
  enabled = true
}

vim.keymap.set('n', '<leader>doc', 'g_<cmd>Neogen<cr>')
