local mp = require 'mp'
local msg = require 'mp.msg'
local utils = require 'mp.utils'

local opts = {
  enabled = true,
  wakatime_cli = 'wakatime',
  wakatime_home = '',
}

require 'mp.options'.read_options(opts)

local timer
local last_path = nil
local timeout = true

-- treat pause and shutdown as "save"
local function heartbeat(write)
  if not opts.enabled then
    return
  end

  local abs_path = nil
  local path = mp.get_property('path')
  if not path then
    if not write or not last_path then
      return
    end
    abs_path = last_path
  elseif path:sub(1, 1) == '/' then
    abs_path = path
  end

  if not abs_path then
    local pwd = mp.get_property('working-directory')
    local result = mp.command_native {
      name = 'subprocess',
      args = { 'realpath', utils.join_path(pwd, path) },
      playback_only = false,
      capture_stdout = true,
    }
    if result.status ~= 0 then
      return
    end
    abs_path = result.stdout:gsub('\n$', '')
  end

  if not write and not timeout and abs_path == last_path then
    return
  end
  timer:kill()
  timer:resume()
  timeout = false

  local version = mp.get_property('mpv-version'):match("([0-9.]*)$")
  local suffix = abs_path:match("%.([^%.]+)$")
  local language = (suffix or 'unknown') .. '-' ..
      (mp.get_property('current-tracks/audio/lang') or
        mp.get_property('current-tracks/video/lang') or
        mp.get_property('current-tracks/sub/lang') or 'unknown')
  local dir = abs_path:match(".*/(.+)/.*")

  local args = {
    opts.wakatime_cli,
    '--entity', abs_path,
    '--plugin', 'mpv/' .. version .. ' mpv-wakatime/0.1',
    '--language', language,
    '--project', dir,
  }

  if write then
    table.insert(args, '--write')
  end

  local envs = opts.wakatime_home == '' and {} or { 'WAKATIME_HOME=' .. opts.wakatime_home }

  msg.verbose(table.concat(envs, ' ') .. ' ' .. table.concat(args, ' '))

  mp.command_native {
    name = 'subprocess',
    args = args,
    env = envs,
    detach = true,
    playback_only = false,
  }

  last_path = abs_path
end

mp.register_event('file-loaded', function()
  heartbeat(false)
end)

timer = mp.add_periodic_timer(120, function()
  timeout = true
  local paused = mp.get_property_native('pause')
  if not paused then
    heartbeat(false)
  end
end)

mp.observe_property('pause', 'bool', function(_, paused)
  heartbeat(paused)
end)

mp.register_event('shutdown', function()
  heartbeat(true)
end)
