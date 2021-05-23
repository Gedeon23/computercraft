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

function Level(direction)
    for i = 1 + direction, 16 + direction do 
        Mine(15)

        -- if anything breaks its this shit
        if i == 16 + direction then
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
    for i = 1, height do
        turtle.digUp()
        turtle.up()
    end
end

function ReturnTurtle(NumberOfStories)

end

function Quarry(height)
    -- quarries one chunk starting from the right corner given a y height
    NumberOfStories = (height - (height%3))/3

    for i = 1, NumberOfStories do
        descend(3)
        Level(i%2)
    end
end


-- Mainloop
print('make sure you have placed the quarry one block above the ground (your y-cord + 1) and in the right corner of the chunk')
sleep(1)
print('What is your height (y-coordinate) ?')
local height = read()
Quarry(height)
