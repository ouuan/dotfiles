local mp = require 'mp'
local utils = require 'mp.utils'

local add_track = function(type, filter)
  local cwd = mp.get_property('working-directory')
  local parent_dir = utils.split_path(cwd)

  local dialog_result = mp.command_native {
    name = 'subprocess',
    args = {
      'kdialog',
      '--title',
      'Add ' .. type .. ' - mpv',
      '--getopenfilename',
      type == 'sub' and parent_dir or cwd,
      filter,
    },
    capture_stdout = true,
  }

  if dialog_result.status == 0 and dialog_result.stdout ~= nil then
    local path = dialog_result.stdout:gsub('\n', '')
    local add_result = mp.commandv(type .. '-add', path)
    if add_result == true then
      mp.osd_message(type .. ' added: ' .. path)
      return
    end
  end

  mp.osd_message('Failed to add ' .. type)
end

mp.add_key_binding(
  nil,
  'add-audio',
  function()
    add_track(
      'audio',
      'Audio files (*.3ga *.aa *.aac *.aax *.act *.aiff *.alac *.amr *.ape *.au *.awb *.dct *.dss *.dvf *.flac *.gsm *.iklax *.ivs *.m4a *.m4b *.m4p *.m4r *.m4v *.mka *.mlp *.mmf *.mp3 *.mpc *.msv *.nmf *.ogg *.oga *.mogg *.opus *.ra *.ram *.rm *.rmp *.sln *.spx *.thd *.tsa *.tta *.voc *.vox *.wav *.wma *.wv *.webm)'
    )
  end
)

mp.add_key_binding(
  nil,
  'add-video',
  function()
    add_track(
      'video',
      'Video files (*.3g2 *.3gp *.amv *.asf *.avi *.drc *.flv *.f4v *.f4p *.f4a *.f4b *.gif *.gifv *.m4v *.mkv *.mng *.mov *.mp4 *.m4p *.m4v *.mpg *.mpeg *.m2v *.mxf *.nsv *.ogg *.ogv *.qt *.rm *.rmvb *.roq *.svi *.vob *.webm *.wmv *.yuv)'
    )
  end
)

mp.add_key_binding(
  nil,
  'add-subtitle',
  function()
    add_track(
      'sub',
      'Subtitle files (*.aqt *.ass *.dat *.dks *.dks *.jss *.sub *.ttxt *.mpl *.txt *.pjs *.psb *.rt *.s2k *.sbt *.smi *.son *.srt *.ssa *.sst *.ssf *.stl *.sub *.svcd *.srt *.usf *.idx *.ssf *.vsf *.zeg *.vtt)'
    )
  end
)
