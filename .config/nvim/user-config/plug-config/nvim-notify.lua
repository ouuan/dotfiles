local notify = require 'notify'

notify.setup {
  level = vim.log.levels.DEBUG,
}

vim.notify = notify

vim.keymap.set({'n', 'x'}, '<leader>q', notify.dismiss, { desc = 'Close notifications' })
vim.keymap.set({'n', 'x'}, '<leader>h', '<cmd>Notifications<cr>', { desc = 'Notifications history' })
