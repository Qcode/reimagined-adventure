Frott = Boss:subclass('Frott')

local frottImage = love.graphics.newImage('graphics/frott.png')
local imageWidth, imageHeight = frottImage:getWidth(), frottImage:getHeight()
local frottQuads = {
    idle = {love.graphics.newQuad(0, 0, 196, 196, imageWidth, imageHeight)},
    shoot = {love.graphics.newQuad(197, 0, 196, 196, imageWidth, imageHeight)}
}

function Frott:init(properties)
    self.parent.init(self, properties)
    self.image = frottImage
    self.quad = 1
    self.quadset = frottQuads
    self.image = frottImage
    self.animation = 'idle'
    self.width = 6.125
    self.height = 6.125
end

function Frott:draw()
    love.graphics.draw(
        self.image,
        self.quadset[self.animation][self.quad],
        self.x*gameManager.tileSize,
        self.y*gameManager.tileSize
    )
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle(
        'line',
        self.x*gameManager.tileSize,
        self.y*gameManager.tileSize,
        self.width*gameManager.tileSize,
        self.height*gameManager.tileSize
    )
    love.graphics.setColor(255, 255, 255)
end
