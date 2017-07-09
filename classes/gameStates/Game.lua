Game = GameState:subclass('Game')

function Game:initialize()
    love.graphics.setBackgroundColor(255, 255, 255)
    self.gameObjects = {}
    self:newObject(Player)
end

function Game:update(dt)
	for classReference, table in pairs(self.gameObjects) do
		for objectNumber, object in pairs(table) do
			object:update(dt)
		end
	end
end

function Game:draw()
	for classReference, table in pairs(self.gameObjects) do
		for objectNumber, object in pairs(table) do
			object:draw()
		end
	end
end

function Game:keypressed(key)
end

function Game:mousepressed(x, y, button)
end

function Game:newObject(objectClass, properties)
    if not self.gameObjects[objectClass] then
        self.gameObjects[objectClass] = {}
    end
    table.insert(self.gameObjects[objectClass], objectClass:new(properties))
end
