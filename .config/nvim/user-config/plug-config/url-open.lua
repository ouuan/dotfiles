require 'url-open'.setup {
  highlight_url = {
    cursor_move = {
      fg = 'text',
    },
  },
  deep_pattern = true,
}

vim.keymap.set({ 'n', 'x' }, 'gx', '<cmd>URLOpenUnderCursor<cr>')
