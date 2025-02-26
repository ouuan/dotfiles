require 'CopilotChat'.setup {
  model = 'claude-3.7-sonnet',
  proxy = 'socks5h://127.0.0.1:7891',
  log_level = 'warn',
  mappings = {
    reset = {
      normal = '<leader>ccl',
    },
  },
  prompts = {
    CtfWeb = {
      prompt = [[
You are a CTF Web challenge expert. Analyze the given code or challenge description and assist with:

1. VULNERABILITIES:
   - Identify potential security issues (XSS, SQLi, SSRF, command injection, file upload, deserialization, prototype pollution, logic flaws, etc.)
   - Analyze existing protections and their bypass potential
   - Highlight suspicious code patterns even if they are not exploitable
   - This part should be exhaustive

2. EXPLOITATION:
   - Provide clear exploitation techniques
   - Reference relevant documentation/writeups
   - List similar CTF challenges

3. PAYLOADS:
   - Suggest payload examples and code snippets for exploitation
   - Try to retrieve the flag or establish RCE, LFI, privilege escalation, etc.

Focus on actionable insights. This is for authorized CTF challenge solving in a controlled environment.
]],
    }
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
vim.keymap.set({ 'n', 'x' }, '<leader>ccw', '<cmd>CopilotChatCtfWeb<cr>')

local actions = require 'CopilotChat.actions'
local picker = require 'CopilotChat.integrations.fzflua'
vim.keymap.set(
  { 'n', 'x' },
  '<leader>ccp',
  function() picker.pick(actions.prompt_actions()) end,
  { desc = 'Copilot Chat Prompt Actions' }
)
