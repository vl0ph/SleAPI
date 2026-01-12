# SleAPI

> Library for the **Figura** mod that provides timing helpers, animation automation, and player interaction functions

🔗 **Russian documentation:** [README_RU.md](./README_RU.md)

---

## 📦 Installation

1. Download `SleAPI.lua`
2. Place it inside your Figura avatar folder
3. Require it in your script:

```lua
local SleAPI = require("SleAPI")
````

---

## 📚 Documentation

### `SleAPI.sleep(time, callback)`

Executes a function after a delay in **seconds**.

**Parameters**

* `time` (`number`) — Delay in seconds
* `callback` (`function`) — Function executed after delay

```lua
SleAPI.sleep(3, function()
    print("3 seconds passed")
end)
```

---

### `SleAPI.tickSleep(time, callback)`

Executes a function after a delay in **ticks**.

**Parameters**

* `time` (`number`) — Delay in ticks
* `callback` (`function`) — Function executed after delay

```lua
SleAPI.tickSleep(40, function()
    print("40 ticks passed")
end)
```

---

### `SleAPI.randAnim(animation, delay, offset?, doubleChance?)`

Automatically plays an animation at random intervals.

**Parameters**

* `animation` (`Animation`) — Figura animation
* `delay` (`number`) — Base delay in ticks
* `offset` (`number`, optional) — Random ± offset
* `doubleChance` (`number`, optional) — Chance (0–1) to play animation twice

**Returns**

* `SleRandomAnim` object

```lua
local blink = SleAPI.randAnim(
    animations.model.idle,
    220,
    40,
    0.1
)
```

#### Methods--  ____  _         _    ____ ___ 
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

```lua
blink:play()
blink:stop()
blink:isPlaying()
```

---

### `SleAPI.blinkAnim(animation, delay, offset?, doubleChance?)`

Same as `randAnim`, but **automatically disables itself while the player is sleeping**.

```lua
local blink = SleAPI.blinkAnim(
    animations.model.blinking, 
    100, 
    30, 
    0.3
)
```

Supports the same methods as `SleRandomAnim`.

---

### `SleAPI.dryingAction(callback, delay)`

Triggers a callback after the player stops being wet for a certain amount of time.

**Parameters**

* `callback` (`function`) — Called after drying finishes
* `delay` (`number`) — Drying duration in ticks


```lua
SleAPI.dryingAction(function()
    animations.model.drying:play()
end, 60)
```

---

### `SleAPI.eyeTracking(...)`

Makes eyes (and optionally head) track the nearest player in front of you.

**Parameters**

* `eyePart` (`ModelPart`) — Eye model part
* `right` (`number`) — Max right movement
* `left` (`number`) — Max left movement
* `up` (`number`) — Max up movement
* `down` (`number`) — Max down movement
* `headPart` (`ModelPart`, optional) — Head model part
* `rotH` (`number`, optional) — Max horizontal head rotation
* `rotV` (`number`, optional) — Max vertical head rotation

```lua
Left_Eye = SleAPI.eyeTracking(
    models.model.root.Head.Eyes.pupilLeft,
    0,
    0.7,
    0,
    0,
    models.model.root.Head,
    30,
    40
)
```

---

## 🗂 Version History

### **1.2** (Current)

* Added `randAnim`
* Added `blinkAnim`
* Added `dryingAction`
* Added `eyeTracking`
* Internal refactoring

### **1.1**

* Added `tickSleep`
* Renamed to **SleAPI**

### **1.0**

* Initial release

---

## 👤 Author

**vloph**

* Discord: `@vloph`
* Telegram: `@dotbyby`

---

## ❤️ License

This project is licensed under the **MIT License**.  
See the [LICENSE](./LICENSE) file for details.

Free to use in personal and public Figura avatars.  
Credit is appreciated but not required.

---

Enjoy using **SleAPI** for your Figura avatars! ✨
