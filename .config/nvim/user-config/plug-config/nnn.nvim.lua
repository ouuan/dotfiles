require 'nnn'.setup {
  picker = {
    style = {
      width = 0.8,
    }
  }
}

vim.keymap.set('n', '<leader>n', '<cmd>NnnPicker %:p<cr>')
