# 🔑 دليل إنشاء Keystore - خطوة بخطوة

## ✅ الخطوة 1: فتح PowerShell

1. اضغط `Windows + X`
2. اختر **Windows PowerShell** أو **Terminal**

---

## ✅ الخطوة 2: الانتقال للمجلد الصحيح

انسخ والصق هذا الأمر:

```powershell
cd "C:\New folder\Desktop\Taabor\mobile_app\android\app"
```

اضغط **Enter**

---

## ✅ الخطوة 3: إنشاء Keystore

انسخ والصق هذا الأمر **كامل**:

```powershell
keytool -genkey -v -keystore taabor-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias taabor
```

اضغط **Enter**

---

## ✅ الخطوة 4: أجب على الأسئلة

البرنامج سيسألك أسئلة، أجب كالتالي:

### 🔐 Enter keystore password

```
أدخل كلمة مرور قوية (مثلاً: Taabor@2024#Secure)
```

**⚠️ احفظها جيداً! ستحتاجها لاحقاً**

### 🔐 Re-enter new password

```
نفس كلمة المرور مرة أخرى
```

### 👤 What is your first and last name?

```
Taabor Team
```

### 🏢 What is the name of your organizational unit?

```
Development
```

### 🏛️ What is the name of your organization?

```
Taabor
```

### 🌍 What is the name of your City or Locality?

```
Baghdad
```

(أو مدينتك)

### 🗺️ What is the name of your State or Province?

```
Baghdad
```

### 🌐 What is the two-letter country code for this unit?

```
IQ
```

(أو رمز دولتك: SA, AE, EG, ...)

### ✅ Is CN=Taabor Team, OU=Development, ... correct?

```
yes
```

### 🔐 Enter key password

```
اضغط Enter (سيستخدم نفس keystore password)
```

---

## ✅ الخطوة 5: التأكد من إنشاء Keystore

نفذ:

```powershell
ls taabor-release-key.jks
```

يجب أن ترى:

```
-a----        12/16/2024   1:00 AM           2648 taabor-release-key.jks
```

---

## ✅ الخطوة 6: تحويل لـ Base64

انسخ والصق:

```powershell
certutil -encode taabor-release-key.jks keystore_base64.txt
```

اضغط **Enter**

يجب أن ترى:

```
Input Length = 2648
Output Length = 3680
CertUtil: -encode command completed successfully.
```

---

## ✅ الخطوة 7: فتح ملف Base64

نفذ:

```powershell
notepad keystore_base64.txt
```

سيفتح Notepad بمحتوى طويل يبدأ بـ:

```
-----BEGIN CERTIFICATE-----
MIIFf...
...
-----END CERTIFICATE-----
```

---

## ✅ الخطوة 8: نسخ المحتوى

### ⚠️ مهم جداً

1. **احذف** السطر الأول: `-----BEGIN CERTIFICATE-----`
2. **احذف** السطر الأخير: `-----END CERTIFICATE-----`
3. **انسخ** ما تبقى فقط (الحروف والأرقام)

**أو**

انسخ **كل شيء كما هو** (مع BEGIN و END)

---

## ✅ الخطوة 9: إضافة في GitHub

1. اذهب لـ GitHub
2. Settings → Secrets → Actions
3. New repository secret
4. **Name:** `KEYSTORE_BASE64`
5. **Value:** الصق المحتوى المنسوخ
6. Add secret

---

## ✅ الخطوة 10: إضافة باقي Secrets

### KEYSTORE_PASSWORD

```
كلمة المرور التي أدخلتها في الخطوة 4
```

### KEY_PASSWORD  

```
نفس KEYSTORE_PASSWORD
```

### KEY_ALIAS

```
taabor
```

---

## 🎯 انتهيت؟

الآن عندك:

- ✅ `taabor-release-key.jks` - الـ keystore الأصلي
- ✅ `keystore_base64.txt` - النسخة base64
- ✅ Secrets مضافة في GitHub

**⚠️ احفظ ملف keystore في مكان آمن!**

---

## 🆘 لو حصل خطأ

### خطأ: "keytool is not recognized"

**السبب:** Java مش مثبت

**الحل:** ثبّت Java JDK:

```
https://www.oracle.com/java/technologies/downloads/
```

### خطأ: "file exists"

**السبب:** keystore موجود من قبل

**الحل:** احذفه أولاً:

```powershell
rm taabor-release-key.jks
```

ثم أعد الخطوات

---

**جاهز؟ أرسل "تم" وأكمل معك! 🚀**
