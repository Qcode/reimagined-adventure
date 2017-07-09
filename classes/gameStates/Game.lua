Game = GameState:subclass('Game')

function Game:initialize()
    love.graphics.setBackgroundColor(255, 255, 255)
    self.gameObjects = {}
    self:newObject(Player, {x=9.5, y=5.625})
    self:newObject(Tile, {x=0, y=0, width=8, height=1})
    self:newObject(Tile, {x=12, y=0, width=12, height=1})
    self:newObject(Tile, {x=0, y=1, width=1, height=12})
    self:newObject(Tile, {x=19, y=1, width=1, height=12})
    self:newObject(Tile, {x=0, y=10.25, width=20, height=1})
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
                        if object.class ~= object2.class
                            and not object:isInstanceOf(Tile) then
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
        if aabbCollision(object, object2) then
            self:resolveCollision(object, object2)
            object:collision(object2)
            object2:collision(object)
        end
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

local abs = math.abs
function Game:resolveCollision(object, object2)
    local moveObject = (object:isInstanceOf(Player)) and object or object2
    local otherObject = (not object:isInstanceOf(Player)) and object or object2
    local upResolve = otherObject.y - (moveObject.y + moveObject.height)
    local downResolve = otherObject.y + otherObject.height - moveObject.y
    local leftResolve = otherObject.x - (moveObject.x + moveObject.width)
    local rightResolve = otherObject.x + otherObject.width - moveObject.x

    local yResolve = abs(upResolve) < abs(downResolve) and upResolve or downResolve
    local xResolve = abs(leftResolve) < abs(rightResolve) and leftResolve or rightResolve
    if abs(xResolve) < abs(yResolve) then
        yResolve = 0
    elseif abs(yResolve) < abs(xResolve) then
        xResolve = 0
    end
    moveObject.x = moveObject.x + xResolve
    moveObject.y = moveObject.y + yResolve
end
