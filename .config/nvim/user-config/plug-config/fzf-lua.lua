local fz = require 'fzf-lua'

fz.setup {
  grep = {
    rg_opts = "--hidden -g '!.git' " .. fz.defaults.grep.rg_opts,
  }
}

local function globlize(func)
  return function()
    func { rg_glob = true }
  end
end

vim.keymap.set({ 'n', 'x' }, '<leader>o', fz.files, { desc = "fzf open file" })
vim.keymap.set({ 'n' }, '<leader>/', fz.live_grep_glob, { desc = "fzf live grep" })
vim.keymap.set({ 'x' }, '<leader>/', globlize(fz.grep_visual), { desc = "fzf grep selected" })
vim.keymap.set({ 'n' }, '<leader>*', globlize(fz.grep_cword), { desc = "fzf grep word under cursor" })
vim.keymap.set({ 'n', 'x' }, '@/', globlize(fz.grep_last), { desc = "fzf grep last" })
