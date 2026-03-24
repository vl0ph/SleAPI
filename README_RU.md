# SleAPI

> Библиотека для мода **Figura**, предоставляющая функции для работы со временем, автоматизацию анимаций и взаимодействия с игроками

🔗 **Английская документация:** [README.md](./README.md)

---

## 📦 Установка

1. Скачайте `SleAPI.lua`
2. Поместите файл в папку аватара Figura
3. Подключите его в своём скрипте:

```lua
local SleAPI = require("SleAPI")
```

---

## 📚 Документация

### `SleAPI.sleep(time, callback)`

Выполняет функцию с задержкой в **секундах**.

**Параметры**

* `time` (`number`) — Задержка в секундах
* `callback` (`function`) — Функция, выполняемая после задержки

```lua
SleAPI.sleep(3, function()
    print("Прошло 3 секунды")
end)
```

---

### `SleAPI.tickSleep(time, callback)`

Выполняет функцию с задержкой в **тиках**.

**Параметры**

* `time` (`number`) — Задержка в тиках
* `callback` (`function`) — Функция, выполняемая после задержки

```lua
SleAPI.tickSleep(40, function()
    print("Прошло 40 тиков")
end)
```

---

### `SleAPI.randAnim(animation, delay, offset?, doubleChance?)`

Автоматически проигрывает анимацию через случайные промежутки времени.

**Параметры**

* `animation` (`Animation`) — Анимация Figura
* `delay` (`number`) — Базовая задержка в тиках
* `offset` (`number`, необязательно) — Случайное отклонение ±
* `doubleChance` (`number`, необязательно) — Шанс (0–1) проиграть анимацию дважды

**Возвращает**

* Объект `SleRandomAnim`

```lua
local blink = SleAPI.randAnim(
    animations.model.idle,
    220,
    40,
    0.1
)
```

#### Методы

```lua
blink:play()
blink:stop()
blink:isPlaying()
```

---

### `SleAPI.blinkAnim(animation, delay, offset?, doubleChance?)`

То же самое, что и `randAnim`, но **автоматически отключается, когда игрок спит**.

```lua
local blink = SleAPI.blinkAnim(
    animations.model.blinking, 
    100, 
    30, 
    0.3
)
```

Поддерживает те же методы, что и `SleRandomAnim`.

---

### `SleAPI.dryingAction(callback, delay)`

Вызывает функцию после того, как игрок перестаёт быть мокрым спустя заданное время.

**Параметры**

* `callback` (`function`) — Вызывается после завершения высыхания
* `delay` (`number`) — Время высыхания в тиках

```lua
SleAPI.dryingAction(function()
    animations.model.drying:play()
end, 60)
```

---

### `SleAPI.eyeTracking(...)`

Заставляет глаза (и опционально голову) следить за ближайшим игроком перед вами.

**Параметры**

* `eyePart` (`ModelPart`) — Часть модели глаз
* `right` (`number`) — Максимальное смещение вправо
* `left` (`number`) — Максимальное смещение влево
* `up` (`number`) — Максимальное смещение вверх
* `down` (`number`) — Максимальное смещение вниз
* `headPart` (`ModelPart`, необязательно) — Часть модели головы
* `rotH` (`number`, необязательно) — Максимальный поворот головы по горизонтали
* `rotV` (`number`, необязательно) — Максимальный поворот головы по вертикали

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

## 🗂 История версий

### **1.2** (Текущая)

* Добавлен `randAnim`
* Добавлен `blinkAnim`
* Добавлен `dryingAction`
* Добавлен `eyeTracking`
* Внутренний рефакторинг
* 1.2.2: Исправление багов

### **1.1**

* Добавлен `tickSleep`
* Переименовано в **SleAPI**

### **1.0**

* Первый релиз

---

## 👤 Автор

**vloph**

* Discord: `@vloph`
* Telegram: `@dotbyby`

---

## ❤️ Лицензия

Проект распространяется под лицензией **MIT**.
Подробности см. в файле [LICENSE](./LICENSE).

Разрешено свободное использование в личных и публичных аватарах Figura.
Указание авторства приветствуется, но не является обязательным.

---

Наслаждайтесь использованием **SleAPI** в ваших аватарах Figura! ✨
