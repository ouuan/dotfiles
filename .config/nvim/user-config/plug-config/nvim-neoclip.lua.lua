require 'neoclip'.setup {
  history = 20,
  content_spec_column = true,
  enable_persistent_history = true,
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-n>',
        paste_behind = '<c-p>',
      },
    }
  },
}

vim.keymap.set('n', '<leader>"', require 'telescope'.extensions.neoclip.default, { desc = "Pick clipboard" })
