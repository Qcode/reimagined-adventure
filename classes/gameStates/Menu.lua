Menu = class:new()
Menu:addparent(GameState)

function Menu:draw()
    love.graphics.print('This is text!', 320, 180)
end
