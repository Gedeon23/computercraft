local data = fs.open('devices.lua', 'r')
Index = textutils.unserialise(data.readAll())
data.close()

for name, info in Index do
    print(name, ' ip:', info['ip'])
end