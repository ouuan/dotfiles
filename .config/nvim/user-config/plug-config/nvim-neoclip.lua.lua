require('neoclip').setup({
  history = 100,
  content_spec_column = true,
  enable_persistant_history = true,
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-n>',
        paste_behind = '<c-p>',
      },
    }
  },
})

vim.cmd[[nmap <leader>" :lua require('telescope').extensions.neoclip.default()<cr>]]
