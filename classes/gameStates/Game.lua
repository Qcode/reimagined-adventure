Game = GameState:subclass('Game')

function Game:init()
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
    if key == 'space' then
        self:newObject(Bullet, {x=3, y=3})
    end
end

function Game:mousepressed(x, y, button)
    for classReference, table in pairs(self.gameObjects) do
        for objectNumber, object in pairs(table) do
            object:mousepressed(x, y, button)
        end
    end
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
    local bulletCollision = object:isInstanceOf(Bullet)
        or object2:isInstanceOf(Bullet)

    local shape1 = not bulletCollision and object.shape or object.hitboxShape
    local shape2 = not bulletCollision and object2.shape or object2.hitboxShape
    if shape1 == 'square' and shape2 == 'square' then
        if aabbCollision(object, object2) then
            self:resolveCollision(object, object2)
            object:collision(object2)
            object2:collision(object)
        end
    elseif shape1 == 'circle' and shape2 == 'circle' then
        local x1, y1, x2, y2 = object.x, object.y, object2.x, object2.y
        if object.shape == 'square' then
            x1 = object:getCenterX()
            y1 = object:getCenterY()
        end
        if object2.shape == 'square' then
            x2 = object2:getCenterX()
            y2 = object2:getCenterY()
        end
        local collided = circleCollision(
            {x = x1, y = y1, radius = object.radius},
            {x = x2, y = y2, radius = object2.radius}
        )
        if collided then
            object:collision(object2)
            object2:collision(object)
        end
    else
        local circleObject = (shape1 == 'circle') and object or object2
        local squareObject = (shape1 == 'square') and object or object2
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
