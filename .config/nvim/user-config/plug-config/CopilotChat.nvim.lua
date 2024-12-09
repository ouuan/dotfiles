require 'CopilotChat'.setup {
  model = 'claude-3.5-sonnet',
  proxy = 'socks5h://127.0.0.1:7891',
  log_level = 'warn',
  mappings = {
    reset = {
      normal = '<leader>ccl',
    },
  },
}

vim.keymap.set({ 'n', 'x' }, '<leader>ccc', ':CopilotChat ')
vim.keymap.set({ 'n', 'x' }, '<leader>ccl', '<cmd>CopilotChatReset<cr>')
vim.keymap.set({ 'n', 'x' }, '<leader>ccs', '<cmd>CopilotChatToggle<cr>')

vim.keymap.set({ 'n', 'x' }, '<leader>ccd', '<cmd>CopilotChatDocs<cr>')
vim.keymap.set({ 'n', 'x' }, '<leader>cce', '<cmd>CopilotChatExplain<cr>')
vim.keymap.set({ 'n', 'x' }, '<leader>ccf', '<cmd>CopilotChatFix<cr>')
vim.keymap.set({ 'n', 'x' }, '<leader>cco', '<cmd>CopilotChatOptimize<cr>')
vim.keymap.set({ 'n', 'x' }, '<leader>ccr', '<cmd>CopilotChatReview<cr>')
vim.keymap.set({ 'n', 'x' }, '<leader>cct', '<cmd>CopilotChatTests<cr>')

local actions = require 'CopilotChat.actions'
local picker = require 'CopilotChat.integrations.fzflua'
vim.keymap.set(
  { 'n', 'x' },
  '<leader>ccp',
  function() picker.pick(actions.prompt_actions()) end,
  { desc = 'Copilot Chat Prompt Actions' }
)
