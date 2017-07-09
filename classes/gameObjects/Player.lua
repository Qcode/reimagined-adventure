Player = GameObject:subclass('Player')

local leftControl, rightControl, upControl, downControl = 'a', 'd', 'w', 's'
local playerSpeed = 5

function Player:initialize(properties)
    self.parent.initialize(self, properties)
    self.hitboxShape = 'circle'
    self.radius = .4
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
    love.graphics.setColor(0, 0, 255)
    love.graphics.circle(
        'line',
        self:getCenterX()*32,
        self:getCenterY()*32,
        self.radius*32
    )
    love.graphics.setColor(255, 255, 255)
end

function Player:keypressed(key)
end

function Player:mousepressed(x, y, button)
    if button == 1 then
        local xSpeed, ySpeed = getSpeedFromAngle(self, {x = x, y = y})
        local properties = {
            x = self:getCenterX(),
            y = self:getCenterY(),
            xSpeed = xSpeed,
            ySpeed = ySpeed,
            shooterType = 'Player'
        }
        self:getState():newObject(Bullet, properties)
    end
end

function Player:movement()
	self.xSpeed, self.ySpeed = 0, 0
	if self:isLeftDown() then
		self.xSpeed = -playerSpeed
	end
	if self:isRightDown() then
		self.xSpeed = playerSpeed
	end
	if self:isUpDown() then
		self.ySpeed = -playerSpeed
	end
	if self:isDownDown() then
		self.ySpeed = playerSpeed
	end

	self:limitSpeed()
end

function Player:limitSpeed()
	self.xSpeed = math.max(-playerSpeed, self.xSpeed)
	self.xSpeed = math.min(playerSpeed, self.xSpeed)
	self.ySpeed = math.max(-playerSpeed, self.ySpeed)
	self.ySpeed = math.min(playerSpeed, self.ySpeed)
    if self.xSpeed ~= 0 and self.ySpeed ~= 0 then
        self.xSpeed = self.xSpeed / math.sqrt(2)
        self.ySpeed = self.ySpeed / math.sqrt(2)
    end
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
