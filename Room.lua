-- Functions
function Mine(distance)
    for i = 1, distance do
        while not turtle.forward() do
            turtle.dig()
        end
        turtle.digUp()
        turtle.digDown()
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
        print("tidying inventory")
    else 
        print('enough Inventory Imma keep going')
    end
end

function TurnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

function Level(direction, x, z)
    for i = 1 + direction, x + direction do 
        Mine(z - 1)

        -- if anything breaks its this shit
        if i == x + direction then
            print("story complete")
            TurnAround()
        elseif i % 2 == 1 then
           turtle.turnRight()
           Mine(1)
           turtle.turnRight()
        else
            turtle.turnLeft()
            Mine(1)
            turtle.turnLeft()
        end

        TidyInventory()
    end
end

local function descend(height)
    for i = 1, height, 1 do
        turtle.digDown()
        turtle.down()
    end
end

local function ascend(height)
    for i = 1, y do
        turtle.digUp()
        turtle.up()
    end
end

function ReturnTurtle(NumberOfStories)

end

function Room(x, y, z)
    -- quarries one chunk starting from the right corner given a y height
    NumberOfStories = (y - (y%3))/3
    Residual = y%3
    EvenWidth = x%2 == 0


    for i = 1, NumberOfStories do
        if EvenWidth then
            Direction = i%2
        else
            Direction = 1
        end

        descend(3)
        Level(Direction, x, z)
    end

    descend(Residual)
    Level((NumberOfStories+1)%2)
end


-- Mainloop
print('make sure you have placed the turtle one block above the room (your y-cord when on ceiling) and in the right corner of the room')
sleep(0.5)
print('What height should the room have (y) ?')
y = read()
print('What width should the room have (x) ?')
x = read()
print('What depth should the room have (z) ?')
z = read()

Room(x, y, z)
