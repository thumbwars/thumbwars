require "input"

function love.load()
    local height = 667
    local width = 375
    love.window.setMode(width, height, { msaa = 4 })
    love.graphics.setBackgroundColor(1, 1, 1)

    Wand = require("wand")
    Wand.x = width / 2
    Wand.y = height - 150
    Wand.touchX = width / 2
    Wand.touchY = height - 150

    Player = require("player")
    Player.x = width / 2
    Player.y = height / 2

    Message = ""
end

function love.update(dt)
    if Wand.touchId then
        local dx, dy = Wand.getDirection()
        Player.move(dt, dx, dy)

        if Wand.isOutOfRange then
            table.insert(Wand.movements, { x = Wand.touchX, y = Wand.touchY })
        end
    end
end

function love.draw()
    -- Display message
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(Message, 10, 10)

    Wand.draw()
    Player.draw()
end
