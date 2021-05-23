-- functions
Index = {}
Index['darkmode'] = {ip = 17, kind = 'pulse', bool = true, side = 'bottom'}

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
    Index[command] = {ip=ip, kind=kind, bool=bool, side=side}
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