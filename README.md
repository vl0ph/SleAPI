# SleAPI Documentation

SleAPI is a simple Lua library designed for the Figura mod, allowing you to delay the execution of a function (callback) by a specified amount of time, either in seconds or in ticks. This library is useful for implementing timed events or delays in your Figura avatars.

---

## Installation

1. Download the `SleAPI.lua` file.
2. Place it in your Figura avatar directory.
3. Require the library in your script:

```lua
local SleAPI = require("SleAPI")
```

---

## Functions

### `SleAPI.sleep(time, callback)`

Delays the execution of a callback by a specified amount of time in seconds.

#### Parameters:
- **`time`** (`integer`): The delay time in seconds.
- **`callback`** (`function`): The function to execute after the delay.

#### Example:
```lua
SleAPI.sleep(5, function()
    print("5 seconds have passed!")
end)
```

---

### `SleAPI.tickSleep(time, callback)`

Delays the execution of a callback by a specified amount of time in ticks.

#### Parameters:
- **`time`** (`integer`): The delay time in ticks.
- **`callback`** (`function`): The function to execute after the delay.

#### Example:
```lua
SleAPI.tickSleep(60, function()
    print("60 ticks have passed!")
end)
```

---

## Example Usage

```lua
local SleAPI = require("SleAPI")

-- Delay by 3 seconds
SleAPI.sleep(3, function()
    print("3 seconds have passed!")
end)

-- Delay by 40 ticks
SleAPI.tickSleep(40, function()
    print("40 ticks have passed!")
end)
```

---

## Version History

- **1.0**: Initial release.
- **1.1**: Current version
  - Added `tickSleep` function for tick-based delays.
  - Library renamed to **SleAPI**.

---

## Author

- **vloph**
  - Discord: `@vloph`
  - Telegram: `@vl0ph`

---

Enjoy using SleAPI for your Figura avatars! <3

---

# Документация SleAPI

SleAPI — это простая библиотека на Lua для мода Figura, позволяющая откладывать выполнение функции на указанное время в секундах или тиках. Библиотека полезна для реализации временных событий или задержек в ваших аватарах для Figura mod.

---

## Установка

1. Скачайте файл `SleAPI.lua`.
2. Поместите его в директорию с вашим аватаром Figura.
3. Подключите библиотеку в вашем скрипте:

```lua
local SleAPI = require("SleAPI")
```

---

## Функции

### `SleAPI.sleep(time, callback)`

Откладывает выполнение функции на указанное время в секундах.

#### Параметры:
- **`time`** (`integer`): Время задержки в секундах.
- **`callback`** (`function`): Функция, которая будет выполнена после задержки.

#### Пример:
```lua
SleAPI.sleep(5, function()
    print("Прошло 5 секунд!")
end)
```

---

### `SleAPI.tickSleep(time, callback)`

Откладывает выполнение функции на указанное время в тиках.

#### Параметры:
- **`time`** (`integer`): Время задержки в тиках.
- **`callback`** (`function`): Функция, которая будет выполнена после задержки.

#### Пример:
```lua
SleAPI.tickSleep(60, function()
    print("Прошло 60 тиков!")
end)
```

---

## Пример использования

```lua
local SleAPI = require("SleAPI")

-- Задержка на 3 секунды
SleAPI.sleep(3, function()
    print("Прошло 3 секунды!")
end)

-- Задержка на 40 тиков
SleAPI.tickSleep(40, function()
    print("Прошло 40 тиков!")
end)
```

---

## История версий

- **1.0**: Первый релиз.
- **1.1**:  Текущая версия
  - Добавлена функция `tickSleep` для задержек в тиках.
  - Библиотека переименована в **SleAPI** (ранее имела название **VlophAPI**).

---

## Автор

- **vloph**
  - Discord: `@vloph`
  - Telegram: `@vl0ph`

---

Наслаждайтесь использованием SleAPI в ваших аватарах для мода Figura! <3
