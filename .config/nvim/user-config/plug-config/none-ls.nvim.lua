local null_ls = require "null-ls"
local utils = require "null-ls.utils"
local helpers = require "null-ls.helpers"

local xvlog_diagnostics = helpers.diagnostics.from_patterns {
  {
    pattern = '(.+): %[.+%] (.+) %[.+:(%d+)%]',
    groups = { "severity", "message", "row" },
    overrides = {
      severities = {
        ["ERROR"] = 1,
        ["WARNING"] = 2,
        ["INFO"] = 3,
      },
    },
  },
}

local xvlog_sv = {
  name = "xvlog",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "systemverilog" },
  generator = null_ls.generator {
    command = "bwrap", -- only permit writing in /tmp
    args = {
      "--ro-bind", "/", "/",
      "--bind", "/tmp/xvlog", "/tmp/xvlog",
      "--dev", "/dev",
      "/home/ouuan/Xilinx/Vivado/2019.2/bin/xvlog",
      "--sv",
      "$FILENAME",
    },
    cwd = function(params)
      -- output in /tmp
      local dir = '/tmp/xvlog/' .. params.bufnr
      vim.fn.mkdir(dir, 'p')
      return dir
    end,
    to_temp_file = true,
    format = "line",
    check_exit_code = { 0, 1 },
    on_output = xvlog_diagnostics,
  },
}

local xvlog_verilog = {
  name = "xvlog",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "verilog" },
  generator = null_ls.generator {
    command = "bwrap",
    args = {
      "--ro-bind", "/", "/",
      "--bind", "/tmp/xvlog", "/tmp/xvlog",
      "--dev", "/dev",
      "/home/ouuan/Xilinx/Vivado/2019.2/bin/xvlog",
      "$FILENAME",
    },
    cwd = function(params)
      -- output in /tmp
      local dir = '/tmp/xvlog/' .. params.bufnr
      vim.fn.mkdir(dir, 'p')
      return dir
    end,
    to_temp_file = true,
    format = "line",
    check_exit_code = { 0, 1 },
    on_output = xvlog_diagnostics,
  },
}

null_ls.setup {
  sources = {
    xvlog_sv,
    xvlog_verilog,
  },
  root_dir = utils.root_pattern("*.xpr", "*.qpf", ".git")
}
