GameManager = class('GameManager')

local scale = 2

function GameManager:initialize(startingState)
	love.graphics.setDefaultFilter('nearest', 'nearest')
	love.window.setMode(640*scale, 360*scale)
    self.state = startingState
end

function GameManager:update(dt)
    self.state:update(dt)
end

function GameManager:draw()
	love.graphics.scale(scale)
    self.state:draw()
end

function GameManager:keypressed(key)
    self.state:keypressed(key)
end

function GameManager:mousepressed(x, y, button)
    local x, y = x/32/scale, y/32/scale
    self.state:mousepressed(x, y, button)
end

function GameManager:setState(newState)
    self.state:cleanUp()
    self.state = newState:new()
end
