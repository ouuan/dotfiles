require("trouble").setup {
    auto_close = true,
}

vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>TroubleToggle<cr>", {})
