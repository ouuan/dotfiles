-- https://github.com/Saghen/blink.cmp/issues/569#issuecomment-2543882960
local function select_next_count(count, dir)
  return function()
    local list = require 'blink.cmp.completion.list'

    dir = dir or 1

    if #list.items == 0 then
      return
    end

    local target_idx
    if list.selected_item_idx == nil then
      if dir == 1 then
        target_idx = count
      else
        target_idx = #list.items - count + 1
      end
    elseif list.selected_item_idx == #list.items and dir == 1 then
      target_idx = 1
    elseif list.selected_item_idx == 1 and dir == -1 then
      target_idx = #list.items - count + 1
    else
      target_idx = list.selected_item_idx + (count * dir)
    end

    if target_idx < 1 then
      target_idx = 1
    elseif target_idx > #list.items then
      target_idx = #list.items
    end

    list.select(target_idx)
  end
end

local function select_next_copilot()
  local list = require 'blink.cmp.completion.list'

  if #list.items == 0 then
    return
  end

  for i = list.selected_item_idx + 1, #list.items do
    if list.items[i].source_id == 'copilot' then
      list.select(i)
      return
    end
  end

  for i = 1, list.selected_item_idx do
    if list.items[i].source_id == 'copilot' then
      list.select(i)
      return
    end
  end

  vim.schedule(function()
    vim.notify('No Copilot suggestions available', vim.log.levels.INFO, {
      title = 'blink.cmp',
      timeout = 1000,
      hide_from_history = true,
    })
  end)
end

-- constants to calculate next_count so that the selected position is stable
local entries = 10
local max_height = entries + (vim.o.winborder ~= 'none' and 2 or 0)
local scrolloff = 2
local preselect = true
local next_count = entries - scrolloff - (preselect and 1 or 0)

require 'blink.cmp'.setup {
  keymap = {
    preset = 'none',
    ['<C-j>'] = { 'select_next' },
    ['<C-k>'] = { 'select_prev' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    ['<C-u>'] = { select_next_count(next_count, -1) },
    ['<C-d>'] = { select_next_count(next_count, 1) },
    ['<C-b>'] = { 'scroll_documentation_up' },
    ['<C-f>'] = { 'scroll_documentation_down' },
    ['<C-o>'] = { 'show' },
    ['<C-e>'] = { 'cancel' },
    ['<C-h>'] = { 'show_signature', 'hide_signature' },
    ['<C-c>'] = { select_next_copilot },
  },
  completion = {
    documentation = { auto_show = true },
    ghost_text = { enabled = true },
    list = {
      selection = {
        preselect = preselect,
        auto_insert = false,
      },
    },
    menu = {
      max_height = max_height,
      scrolloff = scrolloff,
      -- north does not cover multiline ghost text, waiting for https://github.com/Saghen/blink.cmp/issues/206
      direction_priority = { 'n', 's' },
      draw = {
        columns = {
          { 'kind_icon' },
          { 'label',    'label_description', gap = 1 },
          { 'kind' },
        },
      },
    },
  },
  signature = { enabled = true },
  sources = {
    default = {
      'lsp',
      'buffer',
      'copilot',
      'snippets',
      'path',
      'dict',
    },
    providers = {
      copilot = {
        module = 'blink-copilot',
        score_offset = -1,
        async = true,
      },
      dict = {
        module = 'blink-cmp-dictionary',
        min_keyword_length = 3,
        max_items = 10,
        score_offset = -10,
        opts = {
          dictionary_files = { '/usr/share/dict/words' },
        },
      },
    },
  },
  cmdline = {
    keymap = {
      preset = 'inherit',
      ['<CR>'] = { 'accept_and_enter', 'fallback' },
      ['<Tab>'] = { 'select_next' },
      ['<S-Tab>'] = { 'select_prev' },
    },
    completion = {
      list = { selection = { preselect = false } },
      menu = { auto_show = true },
      ghost_text = { enabled = false },
    },
  },
}
