Player = GameObject:subclass('Player')

local leftControl, rightControl, upControl, downControl = 'a', 'd', 'w', 's'

function Player:initialize(properties)
    self.parent.initialize(self, properties)
end

function Player:update(dt)
	self:movement()
	self.parent.update(self, dt)
end

function Player:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle(
		'fill',
		self.x*32,
		self.y*32,
		self.width*32,
		self.height*32
	)
    love.graphics.setColor(255, 255, 255)
end

function Player:keypressed(key)
    if key == 'y' then
        self.getState():newObject(Bullet)
    end
end

function Player:mousepressed(x, y, button)
end

function Player:movement()
	self.xSpeed, self.ySpeed = 0, 0
	if self:isLeftDown() then
		self.xSpeed = -1
	end
	if self:isRightDown() then
		self.xSpeed = 1
	end
	if self:isUpDown() then
		self.ySpeed = -1
	end
	if self:isDownDown() then
		self.ySpeed = 1
	end

	self:limitSpeed()
end

function Player:limitSpeed()
	self.xSpeed = math.max(-1, self.xSpeed)
	self.xSpeed = math.min(1, self.xSpeed)
	self.ySpeed = math.max(-1, self.ySpeed)
	self.ySpeed = math.min(1, self.ySpeed)
end

function Player:isLeftDown()
	return love.keyboard.isDown(leftControl)
end

function Player:isRightDown()
	return love.keyboard.isDown(rightControl)
end

function Player:isUpDown()
	return love.keyboard.isDown(upControl)
end

function Player:isDownDown()
	return love.keyboard.isDown(downControl)
end
