# ✅ Keystore جاهز! الخطوات التالية

## 🎯 ما تم حتى الآن

✅ إنشاء `taabor-release-key.jks`
✅ تحويله لـ base64
✅ نسخه للـ clipboard

---

## 🔐 الخطوة 1: إضافة Secrets في GitHub (الآن!)

### افتح متصفحك واذهب لـ

```
https://github.com/YOUR_USERNAME/taabor
```

### ثم

1. **Settings** (من الأعلى)
2. **Secrets and variables** → **Actions** (من اليسار)
3. **New repository secret** (الزر الأخضر)

---

### Secret #1: KEYSTORE_BASE64

**Name:**

```
KEYSTORE_BASE64
```

**Value:**

- اضغط `Ctrl + V` (المحتوى منسوخ مسبقاً!)
- **Add secret**

---

### Secret #2: KEYSTORE_PASSWORD

**Name:**

```
KEYSTORE_PASSWORD
```

**Value:**

```
كلمة المرور التي أدخلتها عند إنشاء keystore
```

**Add secret**

---

### Secret #3: KEY_PASSWORD

**Name:**

```
KEY_PASSWORD
```

**Value:**

```
نفس كلمة المرور (عادةً نفس KEYSTORE_PASSWORD)
```

**Add secret**

---

### Secret #4: KEY_ALIAS

**Name:**

```
KEY_ALIAS
```

**Value:**

```
taabor
```

**Add secret**

---

## 📝 الخطوة 2: إضافة باقي Secrets (مؤقتاً)

### إذا ما عندك Google Play حالياً، أضف قيم مؤقتة

#### SERVICE_ACCOUNT_JSON

```json
{"type": "service_account", "project_id": "temporary"}
```

#### FIREBASE_TOKEN

```
temporary_token
```

**ملاحظة:** ستستبدلهم بالقيم الحقيقية لاحقاً

---

## 🎯 الخطوة 3: اختبار CI/CD

### بعد إضافة الـ Secrets، جرّب

```bash
cd "C:\New folder\Desktop\Taabor"

# تأكد من آخر تحديثات
git pull

# اعمل commit بسيط
git add .
git commit -m "test: verify ci/cd setup"
git push origin main
```

### ثم راقب

```
https://github.com/YOUR_USERNAME/taabor/actions
```

يجب أن تشاهد:

- ✅ Tests running
- ✅ Analyzer passing

---

## 📱 نشر نسخة تجريبية؟

### إذا تحب تنشر نسخة تجريبية

```bash
# حدّث رقم الإصدار في pubspec.yaml أولاً
# version: 1.0.0+1

git add mobile_app/pubspec.yaml
git commit -m "chore: bump version to 1.0.0"
git push

# أنشئ tag
git tag v1.0.0-test
git push origin v1.0.0-test
```

**⚠️ لكن:** سيفشل Deploy to Play Store لأنه يحتاج Service Account حقيقي

---

## 🆘 لو ظهر خطأ

**انسخ الخطأ من GitHub Actions وأرسله!**

---

**الآن:** اذهب لـ GitHub وأضف الـ Secrets! 🚀
