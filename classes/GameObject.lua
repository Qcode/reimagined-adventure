GameObject = class:new()

function GameObject:init(properties)
    self.x = 0
    self.y = 0
    self:addProperties(properties)
end

function GameObject:update(dt)
end

function GameObject:draw()
end

function GameObject:keypressed(key)
end

function GameObject:mousepressed(x, y, button)
end
