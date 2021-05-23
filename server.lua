-- functions
function ToggleOnRequest(side)
    print('redstone toggled')
    local senderId, message, protocol = rednet.receive('command')
    redstone.setOutput(message[0], message[1])
end
-- mainloop
rednet.open('left')
print(os.getComputerID())
while true do
    ToggleOnRequest()
end