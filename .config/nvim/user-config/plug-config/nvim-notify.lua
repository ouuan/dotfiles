local notify = require 'notify'

notify.setup {
  level = vim.log.levels.DEBUG,
}

vim.notify = notify
