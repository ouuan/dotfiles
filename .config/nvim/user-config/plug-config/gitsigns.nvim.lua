require 'gitsigns'.setup {
  yadm = { enable = true },
  signs = {
    add          = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '━', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '━', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '≃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd', text = '╏', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' }
  },
  sign_priority = 20,
  max_file_length = 10000,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = 'Next Git hunk' })

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = 'Previous Git hunk' })

    -- Actions
    map({ 'n', 'x' }, '<leader>da', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>dA', gs.stage_buffer, { desc = 'Git state buffer' })
    map('n', '<leader>du', gs.undo_stage_hunk, { desc = 'Undo Git stage' })
    map({ 'n', 'x' }, '<leader>dr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>dR', gs.reset_buffer, { desc = 'Git reset buffer' })
    map('n', '<leader>df', gs.preview_hunk, { desc = 'Git Preview hunk' })
    map('n', '<leader>dF', function() gs.diffthis(); vim.api.nvim_feedkeys('h', 'n', true) end, { desc = 'Git diff buffer' })
    map('n', '<leader>dh', function() gs.diffthis('~'); vim.api.nvim_feedkeys('h', 'n', true) end, { desc = 'Git diff against HEAD' })
    map('n', '<leader>bl', function() gs.blame_line { full = true } end, { desc = 'Git blame line' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
