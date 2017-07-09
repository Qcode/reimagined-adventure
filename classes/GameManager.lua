GameManager = class('GameManager')

function GameManager:initialize(startingState)
    self.state = startingState
end

function GameManager:update(dt)
    self.state:update(dt)
end

function GameManager:draw()
    self.state:draw()
end

function GameManager:keypressed(key)
    self.state:keypressed(key)
end

function GameManager:mousepressed(x, y, button)
    self.state:mousepressed(x, y, button)
end

function GameManager:setState(newState)
    self.state:cleanUp()
    self.state = newState:new()
end
