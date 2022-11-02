require'aerial'.setup {
  manage_folds = false,
  post_jump_cmd = 'exec "normal! zz" | AerialClose',
}

vim.keymap.set('n', '<leader>a', '<cmd>AerialOpen<cr>')
