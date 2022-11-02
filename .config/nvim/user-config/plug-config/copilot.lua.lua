if not vim.api.nvim_buf_get_name(0):find("/home/ouuan/courses/") then
  vim.defer_fn(function()
    require'copilot'.setup {
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
      plugin_manager_path = vim.env.HOME .. "/.config/nvim/plugged",
    }

    require'copilot_cmp'.setup {}
  end, 200)
end
