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
