-- mainloop
while true do
    while redstone.getInput('bottom') do
        turtle.turnLeft()
        turtle.suck()
        turtle.turnRight()

        while turtle.getItemDetail() do
            turtle.drop()
            sleep(0.1)
            redstone.setOutput('top', true)
            sleep(1)
            redstone.setOutput('top', false)
            turtle.suck()
        end
    end
    sleep(5)
end 