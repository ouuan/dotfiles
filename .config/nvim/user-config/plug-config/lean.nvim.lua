local function on_attach(_, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true})
    buf_set_keymap('n', 'H', '<Cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
    buf_set_keymap('n', '<leader>i', '<Cmd>lua require"lean.infoview".get_current_infoview():open()<CR>', {noremap = true})
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require('lean').setup{
  lsp3 = { on_attach = on_attach },
  abbreviations = {
    builtin = true, -- built-in expander
  },
}
