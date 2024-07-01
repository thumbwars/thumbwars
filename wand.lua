Wand = {
    x = 0,
    y = 0,
    touchX = 0,
    touchY = 0,
    radius = 50,
    touchId = nil,
    isOutOfRange = false,
    movements = {}
}


function Wand.draw()
    love.graphics.setColor(0, 0, 1, 0.3)
    love.graphics.circle("fill", Wand.x, Wand.y, Wand.radius)

    love.graphics.setColor(0, 0, 1)
    love.graphics.circle("fill", Wand.touchX, Wand.touchY, Wand.radius / 2)
end

function Wand.getDirection()
    -- Calculate the direction based on the joystick position
    local dx = Wand.touchX - Wand.x
    local dy = Wand.touchY - Wand.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > Wand.radius then
        dx = dx / distance * Wand.radius
        dy = dy / distance * Wand.radius
        Wand.isOutOfRange = true
    else
        Wand.isOutOfRange = false
    end

    -- Normalize direction
    local length = math.sqrt(dx * dx + dy * dy)
    if length > 0 then
        dx = dx / length
        dy = dy / length
    end
    return dx, dy
end

return Wand
