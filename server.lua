-- functions
function ToggleOnRequest(side)
    print('redstone toggled')
    local senderId, message, protocol = rednet.receive('command')
    redstone.setOutput(message[1], message[0])
end
-- mainloop
rednet.open('left')
print(os.getComputerID())
while true do
    ToggleOnRequest()
end