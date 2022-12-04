require'treesj'.setup {
  use_default_keymaps = false,
}

local langs = require'treesj.langs'['presets']

local disable = {
  markdown = true,
  text = true,
  tex = true,
}

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    local opts = { buffer = true }
    local filetype = vim.bo.filetype
    if langs[filetype] then
      vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', opts)
      vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', opts)
    elseif not disable[filetype] then
      vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', opts)
      vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', opts)
    end
  end
})
