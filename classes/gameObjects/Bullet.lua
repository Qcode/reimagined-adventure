Bullet = GameObject:subclass('Bullet')

function Bullet:initialize(properties)
    self.parent.initialize(self, properties)
    self.shape = 'circle'
    self.radius = .25
    self.xSpeed = 1
    self.ySpeed = 1
end

function Bullet:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle('fill', self.x*32, self.y*32, self.radius*32)
    love.graphics.setColor(255, 255, 255)
end

function Bullet:collision(otherObject)
    self.delete = true
end
