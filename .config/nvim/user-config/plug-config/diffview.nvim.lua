local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  use_icons = true,
  file_panel = {
    width = 35,
  },
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<c-j>"]     = cb("select_next_entry"),  -- Open the diff for the next file
      ["<c-k>"]     = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["q"]         = cb("focus_files"),        -- Bring focus to the files panel
    },
    file_panel = {
      ["j"]             = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["x"]             = cb("toggle_stage_entry"), -- Stage / unstage the selected entry.
      ["s"]             = cb("stage_all"),          -- Stage all entries.
      ["u"]             = cb("unstage_all"),        -- Unstage all entries.
      ["r"]             = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<c-j>"]         = cb("select_next_entry"),
      ["<c-k>"]         = cb("select_prev_entry"),
    }
  }
}

require'vimp'.nmap("<leader>dv", ":DiffviewOpen<cr>")
