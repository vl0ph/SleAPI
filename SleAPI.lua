--  ____  _         _    ____ ___ 
-- / ___|| | ___   / \  |  _ \_ _|
-- \___ \| |/ _ \ / _ \ | |_) | | 
--  ___) | |  __// ___ \|  __/| | 
-- |____/|_|\___/_/   \_\_|  |___|                                  
-- Version: 1.1
-- Made by vloph <3
-- Discord: @vloph
-- Telegram: @vl0ph

local SleAPI = {}

local sleepOperations = {}

-- Function to delay execution of a callback by a specified amount of time (in seconds)
---@param time integer The delay time in seconds
---@param callback function The function to execute after the delay
function SleAPI.sleep(time, callback)
    x = time * 20
    local targetTick = world.getTime() + x
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

-- Function to delay execution of a callback by a specified amount of time (in ticks)
---@param time integer The delay time in ticks
---@param callback function The function to execute after the delay
function SleAPI.tickSleep(time, callback)
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

return SleAPI