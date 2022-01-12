local colors = require'gruvbox.colors'

require'scrollbar'.setup {
  handle = {
    text = " ",
    color = colors.bg3,
    hide_if_all_visible = true,
  },
  marks = {
    Search = { text = { "━", "━" }, priority = 0, color = colors.orange },
    Error  = { text = { "━", "━" }, priority = 1, color = colors.red },
    Warn   = { text = { "━", "━" }, priority = 2, color = colors.yellow },
    Info   = { text = { "━", "━" }, priority = 3, color = colors.blue },
    Hint   = { text = { "━", "━" }, priority = 4, color = colors.aqua },
    Misc   = { text = { "━", "━" }, priority = 5, color = colors.purple },
  },
}

require("hlslens").setup({
  build_position_cb = function(plist)
      require('scrollbar.handlers.search').handler.show(plist.start_pos)
  end
})

vim.cmd([[
  augroup scrollbar_search_hide
    autocmd!
    autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
  augroup END
]])
