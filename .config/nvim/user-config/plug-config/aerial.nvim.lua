require 'aerial'.setup {
  post_jump_cmd = 'exec "normal! zz" | AerialClose',
  layout = {
    max_width = { 40, 0.3 },
  },
}

vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
