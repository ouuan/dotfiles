local sub = require 'substitute'

sub.setup {}

vim.keymap.set('x', 'p', sub.visual, { desc = 'Substitute' })

local ex = require 'substitute.exchange'

vim.keymap.set('n', 'cx', ex.operator, { desc = 'Exchange' })
vim.keymap.set('n', 'cxx', ex.line, { desc = 'Exchange line' })
vim.keymap.set('n', 'cxc', ex.cancel, { desc = 'Cancel exchange' })
vim.keymap.set('x', 'X', ex.visual, { desc = 'Exchange' })
