Player = GameObject:subclass('Player')

local leftControl, rightControl, upControl, downControl = 'a', 'd', 'w', 's'
local playerMaxSpeed = 5
local playerAcceleration = 1.74
local playerFriction = 3/4

function Player:init(properties)
    self.parent.init(self, properties)
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
	if self:isLeftDown() then
		self.xSpeed = self.xSpeed - playerAcceleration
	end
	if self:isRightDown() then
		self.xSpeed = self.xSpeed + playerAcceleration
	end
	if self:isUpDown() then
		self.ySpeed = self.ySpeed - playerAcceleration
	end
	if self:isDownDown() then
		self.ySpeed = self.ySpeed + playerAcceleration
	end

    self:applyFriction()
    self:capSpeed()
end

function Player:capSpeed()
	self.xSpeed = math.max(-playerMaxSpeed, self.xSpeed)
	self.xSpeed = math.min(playerMaxSpeed, self.xSpeed)
	self.ySpeed = math.max(-playerMaxSpeed, self.ySpeed)
	self.ySpeed = math.min(playerMaxSpeed, self.ySpeed)
    if math.abs(self.xSpeed) < 1/2 then
        self.xSpeed = 0
    end
    if math.abs(self.ySpeed) < 1/2 then
        self.ySpeed = 0
    end
end

function Player:applyFriction()

    local xDir = self.xSpeed ~= 0 and math.abs(self.xSpeed)/self.xSpeed or 0
    local yDir = self.ySpeed ~= 0 and math.abs(self.ySpeed)/self.ySpeed or 0
    self.xSpeed = self.xSpeed - playerFriction*xDir
    self.ySpeed = self.ySpeed - playerFriction*yDir
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
