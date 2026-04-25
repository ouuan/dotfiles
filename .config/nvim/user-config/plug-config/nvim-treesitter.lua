vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(ev.buf, lang)
    end
  end,
})
