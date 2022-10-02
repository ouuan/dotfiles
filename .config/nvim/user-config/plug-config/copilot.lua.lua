if not vim.api.nvim_buf_get_name(0):find("/home/ouuan/courses/") then
  vim.defer_fn(function()
    require("copilot").setup({
      ft_disable = { "markdown", "help", "gitcommit", "", "text" },
      plugin_manager_path = vim.env.HOME .. "/.config/nvim/plugged",
    })
  end, 200)
end
