local fz = require 'fzf-lua'

fz.setup {
  grep = {
    rg_opts = "--hidden -g '!.git' " .. fz.defaults.grep.rg_opts,
  }
}

local opts = { noremap = true, silent = true }

local function globlize(func)
  return function()
    func { rg_glob = true }
  end
end

vim.keymap.set({ 'n', 'x' }, '<leader>o', fz.files, opts)
vim.keymap.set({ 'n' }, '<leader>/', fz.live_grep_glob, opts)
vim.keymap.set({ 'x' }, '<leader>/', globlize(fz.grep_visual), opts)
vim.keymap.set({ 'n' }, '<leader>*', globlize(fz.grep_cword), opts)
vim.keymap.set({ 'n', 'x' }, '@/', globlize(fz.grep_last), opts)
