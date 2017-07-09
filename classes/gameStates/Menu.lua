Menu = GameState:subclass('Menu')

function Menu:initialize()
    self.instructionsText = {
        'Welcome to Walnut Game!',
        'Use WASD to move around',
        'Left click for primary attack',
        'Right click for secondary attack',
        'Hold right and left mouse buttons down to start',
    }

    self.advanceTimer = Timer:new({
        terminating = true,
        timerLimit = 1.5,
        endCall = function() gameManager:setState(Game) end
    })
end

function Menu:update(dt)
    self.advanceTimer:update(dt)
    if not love.mouse.isDown(1) or not love.mouse.isDown(2) then
       -- self.advanceTimer:reset()
    end
end

function Menu:draw()
    for index, text in ipairs(self.instructionsText) do
        love.graphics.print(
            text,
            math.floor(320-love.graphics.getFont():getWidth(text)/2),
            math.floor(20+index*love.graphics.getFont():getHeight(text)*2)
        )
    end
end
