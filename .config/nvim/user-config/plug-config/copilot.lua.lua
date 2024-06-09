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

  require 'copilot_cmp'.setup {}
end, 200)

-- https://github.com/zbirenbaum/copilot.lua/issues/74
local augroup = vim.api.nvim_create_augroup("copilot-disable-patterns", { clear = true })
for _, pattern in ipairs({ '/home/ouuan/courses/**' }) do
  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    pattern = pattern,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and client.name == 'copilot' then
        vim.defer_fn(function()
          vim.cmd("silent Copilot detach")
        end, 10)
      end
    end,
  })
end
