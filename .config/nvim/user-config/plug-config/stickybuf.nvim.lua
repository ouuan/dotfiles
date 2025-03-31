local stickybuf = require 'stickybuf'

stickybuf.setup {
  get_auto_pin = function(bufnr)
    if vim.bo[bufnr].filetype == 'copilot-chat' then
      return 'filtype'
    end
    return stickybuf.should_auto_pin(bufnr)
  end,
}
