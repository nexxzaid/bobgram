# Bobgram

Telegram iOS client, renamed to **Bobgram**. Builds via GitHub Actions, installs free via Sideloadly.

## Что нужно

- Аккаунт GitHub (бесплатно)
- Аккаунт Apple ID (бесплатно, тот что уже есть на iPhone)
- [Sideloadly](https://sideloadly.io) на Mac или Windows (бесплатно)
- Telegram API ключи (бесплатно — ниже инструкция)

**Денег не нужно.**

## Шаг 1 — Получить Telegram API ключи

1. Зайди на [my.telegram.org](https://my.telegram.org)
2. Войди через свой номер телефона
3. Перейди в **API development tools**
4. Создай приложение → получи `api_id` (число) и `api_hash` (строка)

## Шаг 2 — Создать репо на GitHub и добавить секреты

1. Запушь этот репо на GitHub (если ещё не)
2. Открой: **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Значение |
|--------|----------|
| `TELEGRAM_API_ID` | Число из my.telegram.org |
| `TELEGRAM_API_HASH` | Хеш из my.telegram.org |

## Шаг 3 — Запустить сборку

1. Перейди во вкладку **Actions**
2. Выбери **Build Bobgram**
3. Нажми **Run workflow**
4. Жди ~1-2 часа
5. Скачай `Bobgram-N.ipa` из **Artifacts**

## Шаг 4 — Установить на iPhone через Sideloadly (бесплатно)

1. Скачай [Sideloadly](https://sideloadly.io) на Mac или Windows
2. Подключи iPhone к компьютеру кабелем
3. Перетащи `Bobgram.ipa` в Sideloadly
4. Введи свой Apple ID (тот что на iPhone) — пароль **не сохраняется**
5. Нажми **Start**

> **Важно:** бесплатный Apple ID подписывает приложение на **7 дней**.  
> Через 7 дней нужно повторить шаг 4 (IPA уже скачан, займёт 1 минуту).  
> Или поставь [AltStore](https://altstore.io) — он переподписывает автоматически.

## Структура репо

```
build.yml   — GitHub Actions пайплайн (сборка IPA без сертификата)
patch.sh    — Скрипт замены Telegram → Bobgram
```
