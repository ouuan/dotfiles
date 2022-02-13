local function on_attach(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set('n', 'H', vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set('n', '<leader>i', function() require"lean.infoview".get_current_infoview():open() end, { buffer = bufnr })
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require('lean').setup{
  lsp3 = { on_attach = on_attach },
  abbreviations = {
    builtin = true,
  },
}
