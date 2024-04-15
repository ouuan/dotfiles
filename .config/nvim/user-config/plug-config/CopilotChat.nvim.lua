require 'CopilotChat'.setup {
}

vim.keymap.set('n', '<leader>ccb', ':CopilotChatBuffer ')
vim.keymap.set('n', '<leader>ccc', ':CopilotChat ')
vim.keymap.set('n', '<leader>ccf', '<cmd>CopilotChatFixDiagnostic<cr>')
vim.keymap.set('n', '<leader>ccr', '<cmd>CopilotChatReset<cr>')
vim.keymap.set('x', '<leader>cc', ':CopilotChatVisual ')
