local mp = require 'mp'

local function select_track(type)
  local args = {
    'kdialog',
    '--icon',
    'mpv',
    '--title',
    'Select ' .. type .. ' track - mpv',
    '--geometry',
    '1280x720',
    '--radiolist',
    'Select ' .. type .. ' track',
    'no',
    '(no ' .. type .. ')',
    'on', -- the last one takes effect when there are multiple on
  }

  local count = mp.get_property_number('track-list/count')
  for i = 0, count - 1 do
    local track = mp.get_property_native('track-list/' .. i)
    if track.type == type then
      table.insert(args, tostring(track.id))
      table.insert(
        args,
        (track.title or tostring(track.id))
        .. (track.lang and (' (' .. track.lang .. ')') or '')
        .. (type == 'audio' and (' (' .. track['demux-channel-count'] .. ' channels)') or '')
      )
      table.insert(args, track.selected and 'on' or 'off')
    end
  end

  local dialog_result = mp.command_native {
    name = 'subprocess',
    args = args,
    capture_stdout = true,
  }

  if dialog_result.status == 0 and dialog_result.stdout ~= nil then
    local sel = dialog_result.stdout:gsub('\n', '')
    local set_result = mp.commandv('set', type, sel)
    if set_result == true then
      local current = mp.get_property_native('current-tracks/' .. type)
      mp.osd_message(type .. ' chosen: ' .. (current == nil and '(none)' or current.title or current.lang or current.id))
      return
    end
  end

  mp.osd_message('Failed to select ' .. type)
end

mp.add_key_binding(nil, 'select-audio', function() select_track('audio') end)
mp.add_key_binding(nil, 'select-video', function() select_track('video') end)
mp.add_key_binding(nil, 'select-subtitle', function() select_track('sub') end)

local function confirm_not_stereo()
  local audio = mp.get_property_native('current-tracks/audio')
  if audio == nil then
    return
  end
  local channel_count = audio['demux-channel-count'];
  if channel_count ~= 2 then
    mp.set_property('pause', 'yes')
    select_track('audio')
    mp.set_property('pause', 'no')
  end
end

mp.register_event('file-loaded', confirm_not_stereo)
