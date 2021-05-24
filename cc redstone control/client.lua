-- Variables
-- functions


function Request(ip, bool, side)
    print(side, bool)
    rednet.send(ip, {side, bool}, 'command')
    print(string.format('sent signal %s to device %s', tostring(bool), ip))
end

function SendLoop(ip , kind, bool, side)
    if kind == 'toggle' then
        Request(ip, bool, side)
    else 
        Request(ip, bool, side)
        sleep(1)
        Request(ip, not bool, side)
    end
    print('wrapping up send loop')
    sleep(1)
end

-- mainloop
local tArgs = { ... }

if (#tArgs ~= 1) then
  print( "USAGE: cmd <DEVICE-NAME> <SIGNAL (optional)>" )
  return
end

local deviceName = tArgs[1]
local signal = tArgs[2]

local rawIndex = fs.open('devices.lua', 'r')
Index = textutils.unserialise(rawIndex.readAll())
rawIndex.close()

rednet.open('back') 

local device = Index[deviceName]

if signal == 'on' then
    Bool = device.bool
    Kind = 'toggle'
elseif signal == 'off' then
    Bool = not device.bool
    Kind = 'toggle'
elseif signal == nil then
    Bool = true
    Kind = 'pulse'
end

SendLoop(device['ip'], Kind, Bool, device['side'])

-- TODO
-- split functions into single files with commands.txt as db
-- use args instead | example at https://github.com/seriallos/computercraft/blob/master/github.lua