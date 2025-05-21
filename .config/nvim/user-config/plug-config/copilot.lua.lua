vim.defer_fn(function()
  require 'copilot'.setup {
    filetypes = {
      [""] = false,
      ["."] = false,
      csv = false,
      gitcommit = false,
      gitrebase = false,
      help = false,
      markdown = false,
      tex = false,
      text = false,
      typst = false,
      yaml = false,
    },
  }
end, 200)
