# 🚀 دليل النشر خطوة بخطوة - Taabor Production Deployment

## 📋 قائمة المراجعة السريعة

- [ ] Android Keystore جاهز
- [ ] Google Play Service Account جاهز
- [ ] GitHub Secrets مضافة (8 secrets)
- [ ] Firebase CLI جاهز
- [ ] Tests تعمل بنجاح (`flutter test`)
- [ ] رقم الإصدار محدّث في `pubspec.yaml`

---

# ✅ المرحلة 1: إضافة Secrets في GitHub

## 1️⃣ افتح مستودع المشروع

اذهب إلى:

```
https://github.com/YOUR_USERNAME/taabor
```

---

## 2️⃣ ادخل إلى الإعدادات

من أعلى الصفحة، اضغط:

```
Settings (الإعدادات)
```

---

## 3️⃣ Secrets والمتغيرات

من القائمة الجانبية:

```
Secrets and variables → Actions
```

ثم اضغط الزر الأخضر:

```
New repository secret
```

---

## 4️⃣ أضف Secrets (واحداً واحداً)

### 🔐 Android Secrets (4 secrets)

#### ✅ KEYSTORE_BASE64

**Name:**

```
KEYSTORE_BASE64
```

**Value:**
انسخ محتوى keystore بصيغة base64 (الشرح في الأسفل 👇)

**اضغط:** `Add secret`

---

#### ✅ KEYSTORE_PASSWORD

**Name:**

```
KEYSTORE_PASSWORD
```

**Value:**

```
كلمة المرور التي أدخلتها عند إنشاء keystore
```

**اضغط:** `Add secret`

---

#### ✅ KEY_PASSWORD

**Name:**

```
KEY_PASSWORD
```

**Value:**

```
عادةً نفس KEYSTORE_PASSWORD
```

**اضغط:** `Add secret`

---

#### ✅ KEY_ALIAS

**Name:**

```
KEY_ALIAS
```

**Value:**

```
taabor
```

(أو الاسم الذي استخدمته عند إنشاء keystore)

**اضغط:** `Add secret`

---

### 🎯 Google Play Secret (1 secret)

#### ✅ SERVICE_ACCOUNT_JSON

**Name:**

```
SERVICE_ACCOUNT_JSON
```

**Value:**

```json
{
  "type": "service_account",
  "project_id": "your-project",
  "private_key_id": "...",
  "private_key": "...",
  ...
}
```

انسخ **كامل محتوى JSON file** من Google Cloud Console

**اضغط:** `Add secret`

---

### 🍎 iOS/Apple Secrets (4 secrets) - اختياري إذا تنشر على iOS

#### ✅ APPLE_ID

```
your.email@icloud.com
```

#### ✅ APPLE_PASSWORD

```
كلمة مرور Apple ID
```

#### ✅ APP_SPECIFIC_PASSWORD

```
App-specific password من appleid.apple.com
```

#### ✅ MATCH_PASSWORD

```
كلمة مرور لتشفير certificates (أنشئها عشوائية)
```

---

### 🔥 Firebase Secret (1 secret)

#### ✅ FIREBASE_TOKEN

**الخطوات:**

1. افتح Terminal/PowerShell
2. نفّذ:

```bash
firebase login:ci
```

3. سيفتح المتصفح → سجل الدخول
4. سينسخ Token طويل في Terminal
5. انسخه وأضفه كـ secret باسم `FIREBASE_TOKEN`

---

# 📦 المرحلة 2: إنشاء Android Keystore

## إذا لم يكن عندك keystore

### على Windows PowerShell

```powershell
# 1. اذهب لمجلد android/app
cd "C:\New folder\Desktop\Taabor\mobile_app\android\app"

# 2. أنشئ keystore
keytool -genkey -v -keystore taabor-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias taabor
```

**سيسألك:**

- كلمة المرور → أدخلها واحفظها (هذه هي KEYSTORE_PASSWORD)
- إعادة كلمة المرور → نفسها
- اسمك → `Taabor Team`
- اسم الشركة → `Taabor`
- المدينة → مدينتك
- الدولة → `IQ` (أو دولتك)
- رمز الدولة → `IQ`
- تأكيد → `yes`

✅ سيُنشئ ملف: `taabor-release-key.jks`

---

## 5️⃣ تحويل Keystore لـ Base64

### على Windows PowerShell

```powershell
# في نفس المجلد (android/app)
certutil -encode taabor-release-key.jks keystore_base64.txt
```

✅ سيُنشئ ملف `keystore_base64.txt`

**افتحه** وانسخ **كل المحتوى** (بدون السطر الأول والأخير أحياناً)

**الصقه** في GitHub → Secret → `KEYSTORE_BASE64`

---

### على Linux/Mac

```bash
base64 -i taabor-release-key.jks -o keystore_base64.txt
cat keystore_base64.txt
```

---

# 🎮 المرحلة 3: Google Play Service Account

## الخطوات

### 1. Google Cloud Console

اذهب إلى:

```
https://console.cloud.google.com
```

### 2. إنشاء Service Account

```
IAM & Admin → Service Accounts → Create Service Account
```

**الاسم:**

```
github-actions-deployer
```

**الدور:**

```
Service Account User
```

### 3. إنشاء JSON Key

```
Actions → Manage Keys → Add Key → Create new key → JSON
```

سيُحمّل ملف `.json` → **احفظه جيداً**

### 4. ربطه بـ Google Play Console

اذهب إلى:

```
https://play.google.com/console
```

```
Setup → API access → Link the service account
```

**أعطه صلاحية:**

```
Release Manager
```

✅ الآن الـ JSON file جاهز للنسخ في GitHub Secret

---

# 🔥 المرحلة 4: Firebase Token

```bash
# 1. تثبيت Firebase CLI (مرة واحدة)
npm install -g firebase-tools

# 2. تسجيل الدخول
firebase login:ci

# 3. انسخ الـ Token
```

أضف الـ Token في GitHub Secret باسم: `FIREBASE_TOKEN`

---

# 🚀 المرحلة 5: رفع النسخة

## ✅ Commit عادي (Test فقط)

```bash
git add .
git commit -m "setup: configure ci/cd pipeline"
git push origin main
```

**هذا سيشغّل:**

- ✅ Flutter analyze
- ✅ Flutter test
- ✅ Coverage upload

**لن يشغّل:**

- ❌ Android build
- ❌ iOS build
- ❌ Deployment

---

## 🎯 إصدار فعلي (Production Release)

### 1. تحديث رقم الإصدار

في `mobile_app/pubspec.yaml`:

```yaml
version: 1.0.0+1
```

### 2. Commit التحديث

```bash
git add mobile_app/pubspec.yaml
git commit -m "chore: bump version to 1.0.0"
git push origin main
```

### 3. إنشاء Tag

```bash
git tag v1.0.0
git push origin v1.0.0
```

**🎊 الآن CI/CD سيشتغل كاملاً:**

- ✅ Tests
- ✅ Build Android AAB
- ✅ Deploy to Play Store
- ✅ Build iOS (إذا فعّلت)
- ✅ Deploy to TestFlight
- ✅ Firebase Deployment

---

# 📊 المرحلة 6: مراقبة النتيجة

## في GitHub

```
Actions → Taabor CI/CD → أحدث workflow
```

**ستشاهد:**

- ✅ **Test** (2-3 دقائق)
- ✅ **Build Android** (3-5 دقائق)
- ✅ **Build iOS** (5-8 دقائق)
- ✅ **Deploy Firebase** (1-2 دقيقة)

---

## في Google Play Console

```
https://play.google.com/console
→ Taabor
→ Release → Production
```

**يجب أن تشاهد:**

- AAB file جديد
- Version 1.0.0
- Status: In review / Published

---

# ⚠️ استكشاف الأخطاء

## خطأ: "keystore not found"

**السبب:** الـ keystore مش في المكان الصح

**الحل:**

```bash
# تأكد من وجود الملف
ls "c:/New folder/Desktop/Taabor/mobile_app/android/app/taabor-release-key.jks"
```

---

## خطأ: "PERMISSION_DENIED" (Google Play)

**السبب:** Service Account ما عنده صلاحيات

**الحل:**

1. روح Google Play Console
2. Setup → API access
3. اختر الـ Service Account
4. أضف دور: **Release Manager**
5. احفظ
6. انتظر 5-10 دقائق

---

## خطأ: "FIREBASE_TOKEN invalid"

**السبب:** الـ Token قديم أو خطأ في النسخ

**الحل:**

```bash
# احصل على token جديد
firebase login:ci --reauth

# انسخه وحدّث الـ Secret في GitHub
```

---

## خطأ في Analyzer

**السبب:** في warnings أو errors في الكود

**الحل:**

```bash
# شغّل محلياً
flutter analyze --no-fatal-warnings

# إذا في errors حقيقية، اصلحها أولاً
```

---

# 📝 ملاحظات مهمة

## ✅ حفظ Keystore

⚠️ **احفظ keystore في مكان آمن:**

- Google Drive (encrypted)
- Password Manager
- USB مشفر

❗ **إذا ضاع = لا يمكنك تحديث التطبيق أبداً**

---

## 🔐 Secrets آمنة

✅ GitHub Secrets مشفرة
✅ ما تظهر في Logs
✅ فقط الـ Workflow يقدر يوصلها

---

## 🎯 أرقام الإصدار

**Format:**

```
version: MAJOR.MINOR.PATCH+BUILD
```

**أمثلة:**

```yaml
version: 1.0.0+1    # أول إصدار
version: 1.0.1+2    # bug fix
version: 1.1.0+3    # feature جديدة
version: 2.0.0+4    # تغيير كبير
```

---

# 🎉 الخلاصة النهائية

## قائمة المراجعة

- [x] Keystore موجود وBase64 جاهز
- [x] Google Play Service Account جاهز
- [x] 8 GitHub Secrets مضافة
- [x] Firebase Token جاهز
- [x] رقم الإصدار محدّث
- [x] Tests تعمل بنجاح
- [x] Tag مرفوع

## أمر واحد للنشر

```bash
git tag v1.0.0 && git push origin v1.0.0
```

**والباقي تلقائي! 🚀**

---

## 🆘 هل تحتاج مساعدة؟

**إذا ظهر أي خطأ:**

1. اذهب لـ GitHub Actions
2. افتح الـ failed workflow
3. انسخ **أول رسالة خطأ حمراء**
4. أرسلها وسأصلحها فوراً

---

**تم بحمد الله** ✨
