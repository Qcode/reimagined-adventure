Game = class:new()
Game:addparent(GameState)

function Game:init()
    love.graphics.setBackgroundColor(255, 255, 255)
    self.gameObjects = {}
end

function Game:update(dt)
end

function Game:draw()
end

function Game:keypressed(key)
end

function Game:mousepressed(x, y, button)
end

function Game:newObject(objectClass, properties)
    if not self.gameObjects[objectClass] then
        self.gameObjects[objectClass] = {}
    end
    table.insert(self.gameObjects, objectClass:new(properties))
end
