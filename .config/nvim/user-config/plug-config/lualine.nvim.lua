local lualine = require 'lualine'
local async = require 'plenary.async'
local spin_chars = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }

local function cwd()
  if vim.fn.expand('%:.'):sub(1, 1) == '/' then
    return ''
  else
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  end
end

-- https://github.com/ojroques/nvim-hardline/blob/main/lua/hardline/parts/whitespace.lua

local function search(prefix, pattern)
  local line = vim.fn.search(pattern, 'nw')
  if line == 0 then
    return ''
  end
  return string.format('[%s:%d]', prefix, line)
end

local function check_trailing()
  if vim.tbl_contains({ 'markdown' }, vim.bo.filetype) then
    return ''
  end
  return search('trailing', [[\s$]])
end

local function check_mix_indent()
  local tst = [[(^\t* +\t\s*\S)]]
  local tls = string.format([[(^\t+ {%d,}\S)]], vim.bo.tabstop)
  local pattern = string.format([[\v%s|%s]], tst, tls)
  return search('mix-indent', pattern)
end

local function check_conflict()
  local annotation = [[\%([0-9A-Za-z_.:]\+\)\?]]
  local raw_pattern = [[^\%%(\%%(<\{7} %s\)\|\%%(=\{7\}\)\|\%%(>\{7\} %s\)\)$]]
  if vim.bo.filetype == 'rst' then
    raw_pattern = [[^\%%(\%%(<\{7} %s\)\|\%%(>\{7\} %s\)\)$]]
  end
  local pattern = string.format(raw_pattern, annotation, annotation)
  return search('conflict', pattern)
end

local function col_pos()
  local current = vim.fn.charcol('.')
  local total = vim.fn.charcol('$') - 1
  local width = math.max(#tostring(total), 2)
  return string.format('%' .. width .. 'd/%-' .. width .. 'd', current, total)
end

local function line_pos()
  local current = vim.fn.line('.')
  local total = vim.fn.line('$')
  local width = #tostring(total)
  return string.format('%' .. width .. 'd/%-' .. width .. 'd', current, total)
end

local chat = require 'CopilotChat'
local model = nil
local model_spin = 1
local resolving_model = false

local function copilot_chat_model()
  local result = model
  if model == nil then
    result = spin_chars[model_spin]
    model_spin = (model_spin % #spin_chars) + 1
  end
  if resolving_model then
    return result
  end
  resolving_model = true
  async.run(function()
    local resolved_model = chat.resolve_model()
    if resolved_model then
      model = resolved_model
    end
    resolving_model = false
  end)
  return result
end

local function copilot_chat_source()
  local source = chat.get_source()
  local path = vim.api.nvim_buf_get_name(source.bufnr)
  return vim.fn.fnamemodify(path, ":.")
end

local dim_fg = '#C0AE8E';
local dim_col = { fg = dim_fg }
local warn_hl = vim.api.nvim_get_hl(0, { name = 'DiagnosticWarn', link = false })
local warn_fg = string.format("#%06x", warn_hl.fg)
local warn_col = { fg = warn_fg }

lualine.setup {
  options = {
    theme = 'gruvbox-material',
    disabled_filetypes = {
      'padding', -- used in MANPAGER
    },
  },
  sections = {
    lualine_b = { 'branch', 'diff' },
    lualine_c = {
      'diagnostics',
      cwd,
      {
        'filename',
        path = 1,
        symbols = { modified = '●', readonly = '' },
      },
    },
    lualine_x = {
      { check_conflict,   color = warn_col },
      { check_mix_indent, color = warn_col },
      { check_trailing,   color = warn_col },
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_y = { col_pos },
    lualine_z = { line_pos, 'progress' }
  },
  inactive_sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
        symbols = { modified = '●', readonly = '' },
        color = dim_col,
      },
    },
    lualine_x = {},
    lualine_z = {
      { line_pos,   color = dim_col },
      { 'progress', color = dim_col },
    }
  },
  extensions = {
    'aerial',
    'fugitive',
    'fzf',
    'man',
    'quickfix',
    'trouble',
    {
      filetypes = { 'copilot-chat' },
      sections = {
        lualine_a = { '" Chat"' },
        lualine_b = { copilot_chat_model },
        lualine_c = { cwd, copilot_chat_source },
      },
      inactive_sections = {
        lualine_a = { '" Chat"' },
        lualine_c = { { copilot_chat_source, color = dim_col } },
      },
    },
  },
}
