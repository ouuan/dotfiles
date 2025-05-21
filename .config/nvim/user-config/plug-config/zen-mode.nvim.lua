require 'zen-mode'.setup {
  border = 'solid',
  window = {
    width = 80,
    options = {
      number = false,
      relativenumber = false,
    },
  },
}

vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<cr>')
