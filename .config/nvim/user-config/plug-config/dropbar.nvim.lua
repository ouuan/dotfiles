local default_config = require 'dropbar.configs'.opts

require 'dropbar'.setup {
  bar = {
    enable = function(buf, win)
      return default_config.bar.enable(buf, win)
          or vim.bo[buf].ft == 'fugitiveblame'
    end,
    sources = function(buf, win)
      if vim.bo[buf].ft == 'fugitiveblame' then
        return {}
      end
      return default_config.bar.sources(buf, win)
    end
  },
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

vim.keymap.set('n', '<leader>a', function() dropbar_api.pick(3) end, { desc = 'Dropbar Pick' })
