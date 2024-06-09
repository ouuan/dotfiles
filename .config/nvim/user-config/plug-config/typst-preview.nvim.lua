local tp = require 'typst-preview'

tp.setup {
  invert_colors = 'auto',
  open_cmd = 'firefox %s -P typst-preview --class typst-preview'
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = function()
    vim.keymap.set('n', '<leader>p', '<cmd>TypstPreviewToggle<cr>')
  end,
})
