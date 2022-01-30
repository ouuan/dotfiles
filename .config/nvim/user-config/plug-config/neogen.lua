require('neogen').setup {
  enabled = true
}

vim.api.nvim_set_keymap('n', '<leader>doc', '<cmd>Neogen<cr>', {})
