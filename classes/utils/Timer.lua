Timer = class('Timer')

--Properties:
--  timerLimit (required): number, when the timer ends
--  endCall (required): func, function to call when timer is finished
--  terminating (default: false): bool, if timer should be deleted after
--                                                                 finishing

function Timer:init(properties)
    self.terminating = false
    self.currentTime = 0
    self:addProperties(properties)
end

function Timer:update(dt)
    self.currentTime = self.currentTime + dt
    if self.currentTime > self.timerLimit then
        self.currentTime = 0
        self.endCall()
        if self.terminating then
            self = nil
        end
    end
end

function Timer:reset()
    self.currentTime = 0
end
