-- load directory-specific commands from .mpv.exrc with confirmation

local mp = require 'mp'
local msg = require 'mp.msg'
local utils = require 'mp.utils'

local exrc_filename = '.mpv.exrc'

local trusted_path = mp.command_native { 'expand-path', '~~state/exrc-trusted' }
local trusted_set = {}

local function load_trusted()
  local trusted_file = io.open(trusted_path, 'r')
  if trusted_file then
    trusted_file:read('*a'):gsub('[^\n]+', function(line)
      trusted_set[line] = true
    end)
  end
end

local function save_trusted()
  local trusted_file = io.open(trusted_path, 'w')
  if trusted_file == nil then
    return
  end
  for path in pairs(trusted_set) do
    trusted_file:write(path .. '\n')
  end
  trusted_file:close()
end

local function confirm(script_path)
  if trusted_set[script_path] then
    return true
  end

  local args = {
    'kdialog',
    '--icon',
    'mpv',
    '--title',
    'Confirm mpv exrc',
    '--yesno',
    'Load ' .. exrc_filename .. ' from [' .. script_path .. ']?',
  }

  local dialog_result = mp.command_native {
    name = 'subprocess',
    args = args,
    playback_only = false,
  }

  if dialog_result.status == 0 then
    trusted_set[script_path] = true
    save_trusted()
    return true
  end

  return false
end

local exrc_path = utils.getcwd() .. '/' .. exrc_filename
local exrc_commands = {}
local exrc_file = io.open(exrc_path, 'r')
if exrc_file then
  exrc_file:read('*a'):gsub('[^\n]+', function(line)
    table.insert(exrc_commands, line)
  end)
  msg.verbose('Loaded ' .. #exrc_commands .. ' commands from [' .. exrc_path .. ']')
  if #exrc_commands > 0 then
    load_trusted()
    if confirm(exrc_path) then
      msg.verbose('Executing [' .. exrc_path .. ']')
      for _, command in ipairs(exrc_commands) do
        msg.trace('Executing [' .. command .. '] from [' .. exrc_path .. ']')
        mp.command(command)
      end
    end
  end
end
