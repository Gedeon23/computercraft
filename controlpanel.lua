local Monitor = peripheral.wrap("top")

Monitor.write('CONTROL PANEL')

local widthA, heightA = Monitor.getSize()

print("Attached Monitor Size: # of Columns ="..widthA..", Z="..heightA)
