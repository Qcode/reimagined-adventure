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
    for classReference, table in pairs(self.gameObjects) do
        for objectNumber, object in pairs(table) do
            if object.physicsObject then
                for classReference2, table2 in pairs(self.gameObjects) do
                    for objectNumber2, object2 in pairs(table2) do
                        if object.class ~= object2.class then
                            self:collisionDetection(object, object2)
                        end
                    end
                end
            end
        end
    end
    self:deleteObjects()
end

function Game:draw()
	for classReference, table in pairs(self.gameObjects) do
		for objectNumber, object in pairs(table) do
			object:draw()
		end
	end
end

function Game:keypressed(key)
    for classReference, table in pairs(self.gameObjects) do
        for objectNumber, object in pairs(table) do
            object:keypressed(key)
        end
    end
end

function Game:mousepressed(x, y, button)
end

function Game:newObject(objectClass, properties)
    if not self.gameObjects[objectClass] then
        self.gameObjects[objectClass] = {}
    end
    table.insert(self.gameObjects[objectClass], objectClass:new(properties))
end

function Game:deleteObjects()
    for classReference, classTable in pairs(self.gameObjects) do
        for x = #classTable, 1, -1 do
            if classTable[x].delete then
                table.remove(classTable, x)
            end
        end
    end
end

function Game:collisionDetection(object, object2)
    if object.shape == 'square' and object2.shape == 'square' then
    elseif object.shape == 'circle' and object2.shape == 'circle' then
    else
        local circleObject = (object.shape == 'circle') and object or object2
        local squareObject = (object.shape == 'square') and object or object2
        if aabbCircleCollision(squareObject, circleObject) then
            squareObject:collision(circleObject)
            circleObject:collision(squareObject)
        end
    end
end
