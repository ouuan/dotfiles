local mp = require 'mp'

local repeated = false

local function on_key(e)
  if e.event == 'repeat' then
    if not repeated then
      repeated = true
      mp.command('multiply speed 2')
    end
  elseif e.event == 'up' or e.event == 'press' then
    if repeated then
      mp.command('multiply speed 0.5')
    else
      mp.command('seek 2')
    end
    repeated = false
  end
end

mp.add_key_binding(nil, 'fast-forward', on_key, { repeatable = true, complex = true })
