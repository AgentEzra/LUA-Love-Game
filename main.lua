function love.load()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.3)

    -- Load sprite untuk setiap arah
    spriteDown = love.graphics.newImage("playerDownsfix.png")
    spriteLeft = love.graphics.newImage("playerLefts.png")
    spriteRight = love.graphics.newImage("playerRights.png")
    spriteUp = love.graphics.newImage("playerUpsfix.png")

    -- Hitung ukuran frame (asumsi semua ukuran sama)
    frameWidth = spriteDown:getWidth() / 4
    frameHeight = spriteDown:getHeight()

    -- Potong frame untuk masing-masing arah
    frames = {down = {}, left = {}, right = {}, up = {}}
    for i = 0, 3 do
        frames.down[i+1] = love.graphics.newQuad(i * frameWidth, 0, frameWidth, frameHeight, spriteDown:getDimensions())
        frames.left[i+1] = love.graphics.newQuad(i * frameWidth, 0, frameWidth, frameHeight, spriteLeft:getDimensions())
        frames.right[i+1] = love.graphics.newQuad(i * frameWidth, 0, frameWidth, frameHeight, spriteRight:getDimensions())
        frames.up[i+1] = love.graphics.newQuad(i * frameWidth, 0, frameWidth, frameHeight, spriteUp:getDimensions())
    end

    -- Posisi awal
    playerX = love.graphics.getWidth() / 2
    playerY = love.graphics.getHeight() / 2
    speed = 200

    -- Animasi
    currentFrame = 1
    frameTime = 0.15
    timer = 0
    currentDirection = "down"
end

function love.update(dt)
    local moving = false

    if love.keyboard.isDown("w") then
        playerY = playerY - speed * dt
        currentDirection = "up"
        moving = true
    end
    if love.keyboard.isDown("s") then
        playerY = playerY + speed * dt
        currentDirection = "down"
        moving = true
    end
    if love.keyboard.isDown("a") then
        playerX = playerX - speed * dt
        currentDirection = "left"
        moving = true
    end
    if love.keyboard.isDown("d") then
        playerX = playerX + speed * dt
        currentDirection = "right"
        moving = true
    end

    -- Update animasi
    if moving then
        timer = timer + dt
        if timer >= frameTime then
            timer = timer - frameTime
            currentFrame = currentFrame + 1
            if currentFrame > 4 then
                currentFrame = 1
            end
        end
    else
        currentFrame = 1
    end
end

function love.draw()
    local sprite
    if currentDirection == "down" then
        sprite = spriteDown
    elseif currentDirection == "left" then
        sprite = spriteLeft
    elseif currentDirection == "right" then
        sprite = spriteRight
    elseif currentDirection == "up" then
        sprite = spriteUp
    end

    love.graphics.draw(sprite, frames[currentDirection][currentFrame],
        playerX - frameWidth / 2,
        playerY - frameHeight / 2
    )
end
