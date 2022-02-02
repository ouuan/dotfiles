require('neogen').setup {
  enabled = true
}

vim.api.nvim_set_keymap('n', '<leader>doc', 'g_<cmd>Neogen<cr>', {})
