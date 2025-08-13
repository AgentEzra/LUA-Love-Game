function love.load()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.3)
    circleColor = {0, 1, 0}

    radius = 20
    centerX = love.graphics.getWidth() / 2
    centerY = love.graphics.getHeight() / 2
end

function love.draw()
    love.graphics.setColor(circleColor)
    love.graphics.circle("fill", centerX, centerY, radius)
end
