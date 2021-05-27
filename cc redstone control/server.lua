-- mainloop
if not fs.exists('state.lua') then
    local initData = fs.open('state.lua', 'w')
    initData.write('{redston = {}}')
    initData.close()
end


local data = fs.open('state.lua', 'r')
State = textutils.unserialise(data.readAll())
data.close()


for side, bool in pairs(State.redstone) do
    redstone.setOutput(side, bool)
end

rednet.open('left')


print(os.getComputerID())
while true do
    local senderId, message, protocol = rednet.receive('rs_command')

    redstone.setOutput(message[1], message[2])
    
    State.redstone[message[1]] = message[2]

    local data = fs.open('state.lua', 'w')
    data = textutils.serialise(State)
    data.close()

    print('redstone toggled')
end