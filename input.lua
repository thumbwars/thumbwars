function love.touchpressed(id, x, y, dx, dy, pressure)
    if math.sqrt((x - Wand.x) ^ 2 + (y - Wand.y) ^ 2) <= Wand.radius then
        Wand.touchId = id
        Wand.touchX = x
        Wand.touchY = y
    end
end

function love.touchmoved(id, x, y, dx, dy, pressure)
    if id == Wand.touchId then
        Wand.touchX = x
        Wand.touchY = y
    end
end

function love.touchreleased(id, x, y, dx, dy, pressure)
    if id == Wand.touchId then
        Wand.touchId = nil
        Wand.touchX = Wand.x
        Wand.touchY = Wand.y
    end
end

-- Mouse input simulation
function love.mousepressed(x, y, button, istouch, presses)
    if math.sqrt((x - Wand.x) ^ 2 + (y - Wand.y) ^ 2) <= Wand.radius then
        Wand.touchId = "mouse"
        Wand.touchX = x
        Wand.touchY = y
    end
end

function love.mousemoved(x, y, dx, dy, istouch)
    if Wand.touchId == "mouse" then
        Wand.touchX = x
        Wand.touchY = y
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if Wand.touchId == "mouse" then
        Wand.touchId = nil
        Wand.touchX = Wand.x
        Wand.touchY = Wand.y
    end
end

function detectMovementA(movements)
    -- Implement the detection logic for movement A ("/\")
    if #movements < 3 then
        return false
    end

    local first = movements[1]
    local last = movements[#movements]

    local midIndex = math.floor(#movements / 2)
    local mid = movements[midIndex]

    -- Check for upward movement first
    if mid.y < first.y and mid.y < last.y then
        return true
    end

    return false
end

function detectMovementB(movements)
    -- Implement the detection logic for movement B ("V")
    if #movements < 3 then
        return false
    end

    local first = movements[1]
    local last = movements[#movements]

    local midIndex = math.floor(#movements / 2)
    local mid = movements[midIndex]

    -- Check for downward movement first
    if mid.y > first.y and mid.y > last.y then
        return true
    end

    return false
end
