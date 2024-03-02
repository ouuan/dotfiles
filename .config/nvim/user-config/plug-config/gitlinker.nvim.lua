local gitlinker = require 'gitlinker'
local actions = require 'gitlinker.actions'

gitlinker.setup {
  opts = {
    action_callback = actions.open_in_browser,
    add_current_line_on_normal_mode = false,
    print_url = false,
  },
  mappings = nil,
}

vim.keymap.set('n', 'gr', function() gitlinker.get_buf_range_url('n') end, { desc = 'Open file in remote' })
vim.keymap.set('v', 'gr', function() gitlinker.get_buf_range_url('v') end, { desc = 'Open range in remote' })
vim.keymap.set({ 'n', 'v' }, 'gR', gitlinker.get_repo_url, { desc = 'Open repo in remote' })
