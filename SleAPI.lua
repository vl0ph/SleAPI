--  ____  _         _    ____ ___ 
-- / ___|| | ___   / \  |  _ \_ _|
-- \___ \| |/ _ \ / _ \ | |_) | | 
--  ___) | |  __// ___ \|  __/| | 
-- |____/|_|\___/_/   \_\_|  |___|                                  
-- Version: 1.2
-- Made by vloph <3

local SleAPI = {}

---------------------------------------------------------------------
-- UTILITIES
---------------------------------------------------------------------

local function randomDelay(base, offset)
    if not offset or offset == 0 then return base end
    return base + math.random(-offset, offset)
end

---------------------------------------------------------------------
-- sleep
---------------------------------------------------------------------

local sleepOperations = {}

---@param time integer delay in seconds
---@param callback function function called after the delay
function SleAPI.sleep(time, callback)
    assert(type(time) == "number", "time must be number")
    assert(type(callback) == "function", "callback must be function")

    local ticks = time * 20
    local targetTick = world.getTime() + ticks
    local operation = { targetTick = targetTick, callback = callback }

    table.insert(sleepOperations, operation)

    if not sleepOperations.tickHandler then
        sleepOperations.tickHandler = events.TICK:register(function()
            for i = #sleepOperations, 1, -1 do
                local op = sleepOperations[i]
                if world.getTime() >= op.targetTick then
                    op.callback()
                    table.remove(sleepOperations, i)
                end
            end
        end)
    end
end

---------------------------------------------------------------------
-- tickSleep
---------------------------------------------------------------------

---@param time integer delay in ticks
---@param callback function function called after the delay
function SleAPI.tickSleep(time, callback)
    assert(type(time) == "number", "time must be number")
    assert(type(callback) == "function", "callback must be function")

    local targetTick = world.getTime() + time
    local operation = { targetTick = targetTick, callback = callback }

    table.insert(sleepOperations, operation)

    if not sleepOperations.tickHandler then
        sleepOperations.tickHandler = events.TICK:register(function()
            for i = #sleepOperations, 1, -1 do
                local op = sleepOperations[i]
                if world.getTime() >= op.targetTick then
                    op.callback()
                    table.remove(sleepOperations, i)
                end
            end
        end)
    end
end

---------------------------------------------------------------------
-- randAnim
---------------------------------------------------------------------

---@class SleRandomAnim
---@field animation Animation
---@field delay integer
---@field offset integer
---@field double boolean
---@field doubleChance number
---@field playing boolean
---@field nextTick integer
local RandomAnim = {}
RandomAnim.__index = RandomAnim

function RandomAnim:isPlaying()
    return self.playing
end

function RandomAnim:stop()
    self.playing = false
end

function RandomAnim:play()
    self.playing = true
    self.nextTick = world.getTime() + randomDelay(self.delay, self.offset)
end

local randAnimInstances = {}

events.TICK:register(function()
    local now = world.getTime()
    for _, obj in pairs(randAnimInstances) do
        if obj.playing and now >= obj.nextTick then
            obj.animation:play()
            if obj.double and math.random() < obj.doubleChance then
                local doubleObj = {animation = obj.animation, scheduled = true}
                events.TICK:register(function(self)
                    if doubleObj.scheduled and not doubleObj.animation:isPlaying() then
                        doubleObj.animation:play()
                        doubleObj.scheduled = false
                        return true
                    end
                end)
            end

            obj.nextTick = now + randomDelay(obj.delay, obj.offset)
        end
    end
end)

---@param animation Animation
---@param delay integer
---@param offset? integer
---@param doubleChance? number
---@return SleRandomAnim
function SleAPI.randAnim(animation, delay, offset, doubleChance)
    assert(animation and animation.play, "animation must be Figura animation")
    assert(type(delay) == "number", "delay must be number")

    offset = offset or 0
    doubleChance = doubleChance or 0

    local obj = setmetatable({
        animation = animation,
        delay = delay,
        offset = offset,
        double = doubleChance ~= 0,
        doubleChance = doubleChance,
        playing = true,
        nextTick = world.getTime() + randomDelay(delay, offset)
    }, RandomAnim)

    table.insert(randAnimInstances, obj)
    return obj
end

---------------------------------------------------------------------
-- blinkAnim
---------------------------------------------------------------------

---@class SleBlinkAnim: SleRandomAnim
local BlinkAnim = {}
BlinkAnim.__index = BlinkAnim

function BlinkAnim:stop()
    self.playing = false
end

function BlinkAnim:play()
    self.playing = true
    self.nextTick = world.getTime() + randomDelay(self.delay, self.offset)
end

function BlinkAnim:isPlaying()
    return self.playing
end

local blinkInstances = {}

events.TICK:register(function()
    local now = world.getTime()
    local sleeping = player:getPose() == "SLEEPING"

    for _, obj in pairs(blinkInstances) do
        if obj.playing and (not sleeping) and now >= obj.nextTick then
            obj.animation:play()
            if obj.double and math.random() < obj.doubleChance then
                local doubleObj = {animation = obj.animation, scheduled = true}
                events.TICK:register(function(self)
                    if doubleObj.scheduled and not doubleObj.animation:isPlaying() then
                        doubleObj.animation:play()
                        doubleObj.scheduled = false
                        return true
                    end
                end)
            end

            obj.nextTick = now + randomDelay(obj.delay, obj.offset)
        end
    end
end)

---@param animation Animation
---@param delay integer
---@param offset? integer
---@param doubleChance? number
---@return SleBlinkAnim
function SleAPI.blinkAnim(animation, delay, offset, doubleChance)
    assert(animation and animation.play, "animation must be Figura animation")
    assert(type(delay) == "number", "delay must be number")

    offset = offset or 0
    doubleChance = doubleChance or 0

    local obj = setmetatable({
        animation = animation,
        delay = delay,
        offset = offset,
        double = doubleChance ~= 0,
        doubleChance = doubleChance,
        playing = true,
        nextTick = world.getTime() + randomDelay(delay, offset)
    }, BlinkAnim)

    table.insert(blinkInstances, obj)
    return obj
end


---------------------------------------------------------------------
-- dryingAction
---------------------------------------------------------------------

---@class SleDryAction
---@field delay integer
---@field callback function
---@field wasWet boolean
---@field drying boolean
---@field counter integer
local DryAction = {}
DryAction.__index = DryAction

function DryAction:isDrying()
    return self.drying
end

local dryingInstances = {}

events.TICK:register(function()
    local wet = player:isWet()

    for _, obj in pairs(dryingInstances) do
        if wet then
            obj.drying = false
            obj.counter = 0
        else
            if obj.wasWet and not obj.drying then
                obj.drying = true
                obj.counter = 1
            elseif obj.drying then
                obj.counter = obj.counter + 1
                if obj.counter >= obj.delay then
                    obj.callback()
                    obj.counter = 0
                    obj.drying = false
                end
            end
        end
        obj.wasWet = wet
    end
end)

---@param callback function called after drying finishes
---@param delay integer
---@return SleDryAction
function SleAPI.dryingAction(callback, delay)
    assert(type(callback) == "function", "callback must be function")
    assert(type(delay) == "number", "delay must be number")

    local obj = setmetatable({
        callback = callback,
        delay = delay,
        wasWet = false,
        drying = false,
        counter = 0
    }, DryAction)

    table.insert(dryingInstances, obj)
    return obj
end

---------------------------------------------------------------------
-- eyeTracking
---------------------------------------------------------------------

---@class SleEyeTracking
---@field eyePart ModelPart
---@field headPart? ModelPart
---@field right number
---@field left number
---@field up number
---@field down number
---@field rotH number
---@field rotV number

---@param eyePart ModelPart part with eyes
---@param right number max eye movement to the right
---@param left number max eye movement to the left
---@param up number max eye movement up
---@param down number max eye movement down
---@param headPart? ModelPart optional head part for rotation
---@param rotH? number max horizontal head rotation
---@param rotV? number max vertical head rotation
---@return SleEyeTracking
function SleAPI.eyeTracking(eyePart, right, left, up, down, headPart, rotH, rotV)
    assert(eyePart and eyePart.getPos, "eyePart must be a ModelPart")

    up   = up   or 0
    down = down or 0
    rotH = rotH or 0
    rotV = rotV or 0

    local baseEyePos  = eyePart:getPos():copy()
    local baseHeadRot = headPart and headPart:getRot():copy()

    local curEye  = vec(0, 0, 0)
    local curHead = vec(0, 0, 0)

    local obj = {
        eyePart    = eyePart,
        headPart   = headPart,
        right      = right,
        left       = left,
        up         = up,
        down       = down,
        rotH       = rotH,
        rotV       = rotV,
        eyeSmooth  = 0.25,
        headSmooth = 0.15
    }

    events.TICK:register(function()
        local myPos = player:getPos()
        local myRot = player:getRot()

        local forward = vectors.angleToDir(myRot)
        local worldUp = vec(0, 1, 0)
        local rightV  = forward:crossed(worldUp):normalized()
        local upV     = rightV:crossed(forward):normalized()

        local closestDist = math.huge
        local targetX, targetY = 0, 0
        local found = false

        for _, p in pairs(world.getPlayers()) do
            if p ~= player then
                local diff = p:getPos():copy():sub(myPos)
                local dz = diff:dot(forward)
                local dist = diff:length()

                if dist <= 16 and dz > 0 and dist < closestDist then
                    closestDist = dist
                    targetX = diff:dot(rightV) * 16
                    targetY = diff:dot(upV) * 16
                    found = true
                end
            end
        end

        local eyeX, eyeY = 0, 0
        local headX, headY = 0, 0

        if found then
            eyeX = math.clamp(targetX, -left, right)
            eyeY = math.clamp(targetY, -down, up)

            if headPart then
                headY = math.clamp(-targetX * 0.1, -rotH, rotH)

                if targetY > up then
                    headX = math.clamp((targetY - up) * 0.1, -rotV, rotV)
                elseif targetY < -down then
                    headX = math.clamp((targetY + down) * 0.1, -rotV, rotV)
                end
            end
        end

        curEye = curEye + (vec(eyeX, eyeY, 0) - curEye) * obj.eyeSmooth
        eyePart:setPos(baseEyePos + curEye)

        if headPart then
            curHead = curHead + (vec(headX, headY, 0) - curHead) * obj.headSmooth
            headPart:setRot(baseHeadRot + curHead)
        end
    end, "SleEyeTracking_" .. tostring(eyePart))

    return obj
end

---------------------------------------------------------------------

return SleAPI