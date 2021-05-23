-- Constants

-- Functions
local function descend(height)
    for i = 1, height, 1 do
        turtle.digDown()
        turtle.down()
    end
end

local function corridor(length)
    for i = 1, length, 1 do
        turtle.dig()
        turtle.forward()
        turtle.digUp()
        turtle.digDown()
    end
end

local function room(a, b)
    for i = 1, b, 1 do
        corridor(a)
        turtle.turnLeft()
        turtle.turnLeft()

        for i = 1, a, 1 do
            turtle.forward()
        end
        
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    end
end

local function roomFromCenter(a, b)
    turtle.turnLeft()
    turtle.turnLeft()

    for i = 1, a/2, 1 do
        turtle.dig()
        turtle.forward()
    end

    turtle.turnRight()

    for i = 1, b/2, 1 do
        turtle.dig()
        turtle.forward()
    end 

    turtle.turnRight()
    room(a, b)
end
-- Mainloop
descend(51)
roomFromCenter(9,9)

