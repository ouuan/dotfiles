vim.defer_fn(function()
  require 'copilot'.setup {
    filetypes = {
      [""] = false,
      ["."] = false,
      gitcommit = false,
      gitrebase = false,
      help = false,
      markdown = false,
      text = false,
      yaml = false,
    },
  }

  require 'copilot_cmp'.setup {}
end, 200)

-- https://github.com/zbirenbaum/copilot.lua/issues/74#issuecomment-1301498938
vim.api.nvim_create_autocmd({ "LspAttach" }, {
  pattern = '/home/ouuan/courses/**',
  callback = function(args)
    if not args['data'] or not args.data['client_id'] then return end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == 'copilot' then
      vim.lsp.stop_client(client.id, true)
    end
  end
})
