require'project_nvim'.setup {
  detection_methods = { "pattern", "lsp" },
  -- manual_mode = true,
  patterns = {
    ".git",
    "Makefile",
    "package.json",
    "init.vim",
  },
}

require('telescope').load_extension('projects')
vim.keymap.set('n', '<leader>j', '<cmd>Telescope projects<cr>')
