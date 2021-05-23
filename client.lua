-- Variables
-- functions
local rawIndex = fs.open('commands.txt', 'r')
Index = textutils.unserialise(rawIndex.readAll())
rawIndex.close()

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

function NewCommand()
    print('command?')
    command = read()
    print('ip?') 
    ip = tonumber(read())
    print('type?')
    kind = read()
    print('bool?')
    bool = read() == 'true'
    print('side')
    side = read()
    if kind == 'toggle' then
        print('would you like to add a command for', not bool, '(y|n)')
        if read() == 'y' then
            print('what should that command be?')
            command2 = read()
            Index[command2] = {ip=ip, kind=kind, bool=not bool, side=side}
            print('second command for ', not bool, ' has been added')
        end
    end
    Index[command] = {ip=ip, kind=kind, bool=bool, side=side}
    local commands = fs.open('commands.txt', 'w')
    local data = textutils.serialise(Index)
    commands.write(data)
    commands.close()
end
-- mainloop
rednet.open('back') 

while true do 
    print('>')
    Input = read()
    if Input == 'new' then
        NewCommand()
    else
        local command = Index[Input]
        SendLoop(command['ip'], command['kind'], command['bool'], command['side'])
    end
end
