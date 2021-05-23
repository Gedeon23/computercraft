-- constants
Length = 64

-- functions
function Mine(distance)
    for i = 1, distance do
        while not turtle.forward() do
            turtle.dig()
        end
        turtle.digUp()
        turtle.digDown()
    end
end

function TurnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

function Move(distance)
    for i = 1, distance do
        turtle.forward()
    end
end

function CountEmptySlots()
    local emptySlots = 0

    for i = 1, 16 do
        turtle.select(i)
        if not turtle.getItemDetail() then
            emptySlots = emptySlots + 1
        end
    end

    return emptySlots
end

function DumpToEC()
    turtle.select(16)
    turtle.placeDown()

    for i = 1, 15 do
        turtle.select(i)
        turtle.dropDown()
    end

    turtle.select(16)
    turtle.digDown()
    turtle.select(1)
end

function TidyInventory()
    if CountEmptySlots() < 4 then
        DumpToEC()
    else 
        print('enough Inventory Imma keep going')
    end
end

function HalfMine(stripdepth)
    for i = 1, 12 do

        Mine(5)

        turtle.turnLeft()

        Mine(stripdepth)
        
        TurnAround()

        Move(10)

        turtle.turnLeft()

        TidyInventory()
    end
end

function Shaft(stripdepth)
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()

    HalfMine(stripdepth)

    Mine(5)

    turtle.turnRight()

    Mine(2)
    
    turtle.turnRight()

    HalfMine(stripdepth - 1)

    Mine(5)

    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()

    Mine(65)
end

local function room(a, b)
    for i = 1, b, 1 do
        Mine(a)
        TurnAround()
        Move(a)
        turtle.turnLeft()
        Mine(1)
        turtle.turnLeft()
        TidyInventory()
    end
end

function RoomFromFront(a, b)
    turtle.turnLeft()
    Mine(b/2)
    turtle.turnRight()
    room(a,b)
end

-- mainloop
Shaft(7)
RoomFromFront(16,16)