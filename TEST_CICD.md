# 🚀 اختبار CI/CD - خطوة بخطوة

## ✅ الوضع الحالي

- ✅ Keystore جاهز
- ✅ GitHub Secrets مضافة (4 secrets)
- ✅ CI/CD Pipeline جاهز

---

## 🎯 الآن: اختبار Pipeline

### الخطوة 1: Commit بسيط (اختبار Tests فقط)

```bash
cd "C:\New folder\Desktop\Taabor"

# تأكد من حالة Git
git status

# أضف الملفات الجديدة
git add .

# Commit
git commit -m "setup: configure production deployment with keystore"

# Push
git push origin main
```

**المتوقع:**

- ✅ Tests سيعمل
- ✅ Analyzer سيعمل  
- ❌ Build Android **لن يعمل** (لأنه يحتاج tag)

---

### الخطوة 2: راقب GitHub Actions

افتح:

```
https://github.com/YOUR_USERNAME/taabor/actions
```

يجب أن ترى:

- 🔵 Workflow جديد يعمل
- ⏳ Test job running
- ✅ يجب أن ينجح في ~2-3 دقائق

---

### الخطوة 3 (اختياري): اختبار Build كامل

**⚠️ تحذير:** هذا سيحاول رفع APK لـ Play Store!

**فقط إذا كنت جاهز:**

```bash
# حدّث رقم الإصدار أولاً
# في mobile_app/pubspec.yaml
# version: 0.0.1+1

git add mobile_app/pubspec.yaml
git commit -m "chore: bump version to 0.0.1"
git push

# أنشئ tag test
git tag v0.0.1-test
git push origin v0.0.1-test
```

**المتوقع:**

- ✅ Test
- ✅ Build Android AAB
- ❌ Deploy to Play Store (سيفشل - يحتاج SERVICE_ACCOUNT_JSON حقيقي)

---

## 📊 ماذا تتوقع في Actions

### Workflow: "Taabor CI/CD"

```
✅ Test (2-3min)
  ├─ Checkout code
  ├─ Setup Flutter
  ├─ Install dependencies
  ├─ Run analyzer
  └─ Run tests

(إذا عملت tag:)
⏳ Build Android (3-5min)
  ├─ Setup Java
  ├─ Setup Flutter  
  ├─ Decode keystore
  ├─ Build AAB
  └─ ❌ Upload to Play Store (سيفشل - طبيعي)
```

---

## ✅ علامات النجاح

- ✅ `flutter analyze --no-fatal-warnings` passed
- ✅ `flutter test` passed (50+ tests)
- ✅ AAB file created (إذا عملت tag)
- ✅ Keystore decoded successfully

---

## ⚠️ أخطاء محتملة

### 1. "No such file: taabor-release-key.jks"

**السبب:** الـ workflow فك تشفير base64 وحفظه

**الحل:** طبيعي - الـ workflow يتكفل بهذا

### 2. "KEYSTORE_PASSWORD incorrect"

**السبب:** كلمة المرور خطأ في Secret

**الحل:** راجع الـ Secret في GitHub

### 3. Deploy failed: 403 PERMISSION_DENIED

**السبب:** SERVICE_ACCOUNT_JSON مؤقت

**الحل:** طبيعي! تحتاج Service Account حقيقي

---

## 🎯 الخلاصة

**الآن:**

```bash
git add .
git commit -m "setup: configure production deployment"
git push origin main
```

**راقب:** GitHub Actions

**أرسل screenshot** النتيجة! 📸
