function love.load()
    local height = 667
    local width = 375
    -- iPhone dimensions (iPhone 6/7/8)
    love.window.setMode(width, height)
    love.graphics.setBackgroundColor(1, 1, 1)

    Joystick = {
        x = width / 2,
        y = height - 150,
        radius = 50,
        touchId = nil,
        touchX = width / 2,
        touchY = height - 150
    }

    Player = {
        x = width / 2,
        y = height / 2,
        speed = 200
    }
end

function love.update(dt)
    if Joystick.touchId then
        -- Calculate the direction based on the joystick position
        local dx = Joystick.touchX - Joystick.x
        local dy = Joystick.touchY - Joystick.y
        local distance = math.sqrt(dx * dx + dy * dy)

        if distance > Joystick.radius then
            dx = dx / distance * Joystick.radius
            dy = dy / distance * Joystick.radius
        end

        -- Normalize direction
        local length = math.sqrt(dx * dx + dy * dy)
        if length > 0 then
            dx = dx / length
            dy = dy / length
        end

        Player.x = Player.x + dx * Player.speed * dt
        Player.y = Player.y + dy * Player.speed * dt
    end
end

function love.draw()
    love.graphics.print("Debuggin message", 0, 0)

    -- Draw the joystick base
    love.graphics.setColor(0, 0, 1, 0.3) -- Blue with some transparency
    love.graphics.circle("fill", Joystick.x, Joystick.y, Joystick.radius)

    -- Draw the joystick knob
    love.graphics.setColor(0, 0, 1) -- Blue
    love.graphics.circle("fill", Joystick.touchX, Joystick.touchY, Joystick.radius / 2)

    -- Draw the red triangle
    love.graphics.setColor(1, 0, 0) -- Red
    love.graphics.polygon("fill", Player.x, Player.y - 20, Player.x - 15, Player.y + 20, Player.x + 15,
        Player.y + 20)
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    if math.sqrt((x - Joystick.x) ^ 2 + (y - Joystick.y) ^ 2) <= Joystick.radius then
        Joystick.touchId = id
        Joystick.touchX = x
        Joystick.touchY = y
    end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    if id == Joystick.touchId then
        Joystick.touchX = x
        Joystick.touchY = y
    end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    if id == Joystick.touchId then
        Joystick.touchId = nil
        Joystick.touchX = Joystick.x
        Joystick.touchY = Joystick.y
    end
end

-- Mouse input simulation
function love.mousepressed(x, y, button, istouch, presses)
    if math.sqrt((x - Joystick.x) ^ 2 + (y - Joystick.y) ^ 2) <= Joystick.radius then
        Joystick.touchId = "mouse"
        Joystick.touchX = x
        Joystick.touchY = y
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if Joystick.touchId == "mouse" then
        Joystick.touchX = x
        Joystick.touchY = y
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if Joystick.touchId == "mouse" then
        Joystick.touchId = nil
        Joystick.touchX = Joystick.x
        Joystick.touchY = Joystick.y
    end
end
