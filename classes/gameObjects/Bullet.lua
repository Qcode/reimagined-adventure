Bullet = GameObject:subclass('Bullet')
local bulletSpeed = 10
function Bullet:init(properties)
    self.shooterType = 'Enemy'
    self.parent.init(self, properties)
    self.xSpeed, self.ySpeed = self.xSpeed*bulletSpeed, self.ySpeed*bulletSpeed
    self.shape = 'circle'
    self.hitboxShape = 'circle'
    self.radius = .25
end

function Bullet:draw()
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle('fill', self.x*32, self.y*32, self.radius*32)
    love.graphics.setColor(255, 255, 255)
end

function Bullet:collision(otherObject)
    if self.shooterType == 'Enemy' and otherObject:isInstanceOf(Player) then
        self.delete = true
    elseif self.shooterType == 'Player'
        and not otherObject:isInstanceOf(Player) then
        self.delete = true
    end
end
