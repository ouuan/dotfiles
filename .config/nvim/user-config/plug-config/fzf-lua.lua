local fz = require 'fzf-lua'

fz.setup {
  grep = {
    rg_opts = "--hidden -g '!.git' " .. fz.defaults.grep.rg_opts,
  }
}

fz.register_ui_select {}

vim.keymap.set({ 'n', 'x' }, '<leader>o', fz.files, { desc = "fzf open file" })
vim.keymap.set({ 'n' }, '<leader>/', fz.live_grep, { desc = "fzf live grep" })
vim.keymap.set({ 'x' }, '<leader>/', fz.grep_visual, { desc = "fzf grep selected" })
vim.keymap.set({ 'n' }, '<leader>*', fz.grep_cword, { desc = "fzf grep word under cursor" })
vim.keymap.set({ 'n', 'x' }, '@/', function() fz.grep({ resume = true }) end, { desc = "fzf grep last" })
