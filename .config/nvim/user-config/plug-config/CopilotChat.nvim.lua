require 'CopilotChat'.setup {
}

vim.keymap.set({'n', 'x'}, '<leader>ccc', ':CopilotChat ')
vim.keymap.set({'n', 'x'}, '<leader>ccd', '<cmd>CopilotChatDocs<cr>')
vim.keymap.set({'n', 'x'}, '<leader>ccf', '<cmd>CopilotChatFixDiagnostic<cr>')
vim.keymap.set({'n', 'x'}, '<leader>cco', '<cmd>CopilotChatOptimize<cr>')
vim.keymap.set({'n', 'x'}, '<leader>ccr', '<cmd>CopilotChatReset<cr>')
vim.keymap.set({'n', 'x'}, '<leader>cct', '<cmd>CopilotChatTests<cr>')
