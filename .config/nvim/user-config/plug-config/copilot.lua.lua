vim.defer_fn(function()
  require("copilot").setup({
    ft_disable = { "markdown", "help", "gitcommit" },
    plugin_manager_path = vim.env.HOME .. "/.config/nvim/plugged",
  })
end, 200)
