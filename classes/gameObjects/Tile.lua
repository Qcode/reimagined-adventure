Tile = GameObject:subclass('Tile')

function Tile:initialize(properties)
    self.parent.initialize(self, properties)
end

function Tile:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle(
        'fill',
        self.x*32,
        self.y*32,
        self.width*32,
        self.height*32
    )
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle(
        'line',
        self.x*32,
        self.y*32,
        self.width*32,
        self.height*32
    )
    love.graphics.setColor(255, 255, 255)
end
