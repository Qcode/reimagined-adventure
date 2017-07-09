GameObject = class('GameObject')

function GameObject:initialize(properties)
    self.x = 0
    self.y = 0
	self.xSpeed = 0
	self.ySpeed = 0
    self.width = 1
    self.height = 1
    self:addProperties(properties)
end

function GameObject:update(dt)
	self.x = self.x + self.xSpeed*dt
	self.y = self.y + self.ySpeed*dt
end

function GameObject:draw()
end

function GameObject:keypressed(key)
end

function GameObject:mousepressed(x, y, button)
end

function GameObject:getCenterX()
	return self.x + self.width/2
end

function GameObject:getCenterY()
	return self.y + self.height/2
end
