# Bobgram

Telegram iOS client, renamed to **Bobgram**.

## Что это

Форк [Telegram-iOS](https://github.com/TelegramMessenger/Telegram-iOS) с единственным изменением: название приложения изменено с **Telegram** на **Bobgram**. Подключается к серверам Telegram, все функции работают стандартно.

## Как собрать (через GitHub Actions)

### Шаг 1 — Получить Telegram API ключи

1. Зайди на [my.telegram.org](https://my.telegram.org)
2. Войди через свой номер телефона
3. Перейди в **API development tools**
4. Создай приложение, получи `api_id` и `api_hash`

### Шаг 2 — Получить сертификат для подписи

Нужен один из вариантов:

**Вариант A — Apple Developer аккаунт ($99/год)**
- Даёт официальный сертификат
- Приложение не истекает через 7 дней

**Вариант B — Бесплатный Apple ID (через Xcode)**
- Бесплатно
- Приложение нужно переподписывать каждые 7 дней через AltStore/Sideloadly

Для варианта A:
1. Создай Distribution certificate в [Apple Developer](https://developer.apple.com)
2. Создай App ID: `com.yourname.bobgram`
3. Создай Provisioning Profile для этого App ID
4. Скачай сертификат как `.p12` файл (в Keychain Access → Export)

### Шаг 3 — Добавить секреты в GitHub

В репозитории: **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Что туда положить |
|--------|------------------|
| `TELEGRAM_API_ID` | Число из my.telegram.org |
| `TELEGRAM_API_HASH` | Хеш из my.telegram.org |
| `CERT_P12_BASE64` | Сертификат в base64: `base64 -i cert.p12` |
| `CERT_PASSWORD` | Пароль от .p12 файла |
| `PROV_PROFILE_BASE64` | Профиль в base64: `base64 -i profile.mobileprovision` |

### Шаг 4 — Запустить сборку

1. Перейди во вкладку **Actions** в этом репо
2. Выбери **Build Bobgram**
3. Нажми **Run workflow**
4. Жди ~1-2 часа (большой проект)
5. Скачай `Bobgram-N.ipa` из артефактов

### Шаг 5 — Установить на iPhone

**Если есть Developer аккаунт:**
- Используй [Apple Configurator 2](https://apps.apple.com/app/apple-configurator-2/id1037126344) или [Xcode Devices](https://developer.apple.com/documentation/xcode/installing-your-app-on-a-device)

**Если бесплатный Apple ID:**
- Установи [AltStore](https://altstore.io) на iPhone
- Перетащи `.ipa` через AltStore

## Структура репо

```
.github/workflows/build.yml   — GitHub Actions пайплайн
scripts/patch.sh              — Скрипт замены Telegram → Bobgram
```
