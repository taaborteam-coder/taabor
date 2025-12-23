# 🔑 Quick Reference - Keystore Commands

## إنشاء Keystore جديد

```powershell
# Windows PowerShell
cd "C:\New folder\Desktop\Taabor\mobile_app\android\app"

keytool -genkey -v -keystore taabor-release-key.jks `
  -keyalg RSA `
  -keysize 2048 `
  -validity 10000 `
  -alias taabor
```

## تحويل لـ Base64

### Windows

```powershell
certutil -encode taabor-release-key.jks keystore_base64.txt
```

### Linux/Mac

```bash
base64 -i taabor-release-key.jks | pbcopy
```

## معلومات Keystore

```bash
# عرض تفاصيل keystore
keytool -list -v -keystore taabor-release-key.jks

# التحقق من Alias
keytool -list -keystore taabor-release-key.jks
```

## Secrets المطلوبة

### Android (4 secrets)

```
KEYSTORE_BASE64       → محتوى keystore بصيغة base64
KEYSTORE_PASSWORD     → كلمة مرور keystore
KEY_PASSWORD          → كلمة مرور المفتاح (عادةً نفس KEYSTORE_PASSWORD)
KEY_ALIAS             → taabor
```

### Google Play (1 secret)

```
SERVICE_ACCOUNT_JSON  → محتوى JSON file كامل
```

### iOS (4 secrets) - اختياري

```
APPLE_ID              → your.email@icloud.com
APPLE_PASSWORD        → كلمة مرور Apple ID
APP_SPECIFIC_PASSWORD → App-specific password
MATCH_PASSWORD        → كلمة مرور عشوائية للـ certificates
```

### Firebase (1 secret)

```
FIREBASE_TOKEN        → ناتج أمر: firebase login:ci
```

## أوامر سريعة

```bash
# Test محلي
flutter test

# Analyze
flutter analyze --no-fatal-warnings

# رفع نسخة جديدة
git tag v1.0.0 && git push origin v1.0.0

# Firebase login
firebase login:ci
```
