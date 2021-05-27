local tArgs = { ... }

if (#tArgs ~= 4) then
  print( "USAGE: new <DEVICE-NAME> <IP> <ON SIGNAL (boolean)> <SIDE> " )
  return
end

local deviceName = tArgs[1]
local ip = tonumber(tArgs[2])
local bool = tArgs[3] == 'true'
local side = tArgs[4]

local data = fs.open('devices.lua', 'r')
Index = textutils.unserialise(data.readAll())
data.close()

Index[deviceName] = {ip=ip, bool=bool, side=side}
local data = fs.open('devices.lua ', 'w')
data.write(textutils.serialise(Index))
data.close()

print('new device has been added to Index')
sleep(1)
shell.run('clear')