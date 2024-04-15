require 'dropbar'.setup {
  sources = {
    path = {
      relative_to = function() return vim.fn.expand("%:p:h:h") end,
    },
  },
  menu = {
    win_configs = {
      height = function(menu)
        return math.max(
          1,
          math.min(
            #menu.entries,
            math.ceil(vim.go.lines / 2)
          )
        )
      end,
    },
  },
}

local dropbar_api = require 'dropbar.api'

vim.keymap.set('n', '<leader>a', function() dropbar_api.pick(3) end)
