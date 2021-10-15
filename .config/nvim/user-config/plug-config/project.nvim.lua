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
vim.cmd[[nmap <leader>j :Telescope projects<cr>]]
