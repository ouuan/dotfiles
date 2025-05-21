require 'treesj'.setup {
  use_default_keymaps = false,
}

local langs = require 'treesj.langs'['presets']
langs.typescriptreact = langs.tsx

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    local opts = { buffer = true }
    local filetype = vim.bo.filetype
    if langs[filetype] then
      vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', opts)
      vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', opts)
    end
  end
})
