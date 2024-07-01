Player = {
    x = 0,
    y = 0,
    speed = 200,
    angle = 0
}

function Player.move(dt, dx, dy)
    Player.x = Player.x + dx * Player.speed * dt
    Player.y = Player.y + dy * Player.speed * dt
end

function Player.draw()
    love.graphics.setColor(1, 0, 0) -- Red
    love.graphics.push()
    love.graphics.translate(Player.x, Player.y)
    love.graphics.rotate(Player.angle)
    love.graphics.polygon("fill", 0, -20, -15, 20, 15, 20)
    love.graphics.pop()
end

return Player
