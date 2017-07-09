io.stdout:setvbuf('no')
require 'loadFiles'
function love.load()
    print('Loading Game')
    gameManager = GameManager:new(Menu:new())
end

function love.update(dt)
    gameManager:update(dt)
end

function love.draw()
    gameManager:draw()
end

function love.keypressed(key)
    gameManager:keypressed(key)
end

function love.mousepressed(x, y, button)
    gameManager:mousepressed(x, y, button)
end

-- Thanks YellowAfterLife https://yal.cc/rectangle-circle-intersection-test/
local min, max, pow = math.min, math.max
function aabbCircleCollision(aabbObject, circleObject)
    local farX = aabbObject.x + aabbObject.width
    local farY = aabbObject.y + aabbObject.height
    local nearestX = max(aabbObject.x, min(circleObject.x, farX))
    local nearestY = max(aabbObject.y, min(circleObject.y, farY))
    local deltaX, deltaY = circleObject.x - nearestX, circleObject.y - nearestY
    return (deltaX^2 + deltaY^2) < (circleObject.radius^2)
end

function aabbCollision(object, object2)
    local x1, y1, x2, y2 = object.x, object.y, object2.x, object2.y
    local farX1 = object.x + object.width
    local farY1 = object.y + object.height
    local farX2 = object2.x + object2.width
    local farY2 = object2.y + object2.height
    return (farX1 > x2 and x1 < farX2 and farY1 > y2 and y1 < farY2)
end

function getSpeedFromAngle(object, object2)
    local xDist = object2.x - object:getCenterX()
    local yDist = object2.y - object:getCenterY()
    local angle = math.atan2(yDist, xDist)
    return math.cos(angle), math.sin(angle)
end

local dist = function(x1, y1, x2, y2)
    return math.sqrt((x2-x1)^2+(y2-y1)^2)
end

function circleCollision(object, object2)
    local distance = dist(object.x, object.y, object2.x, object2.y)
    return distance < object.radius + object2.radius
end
