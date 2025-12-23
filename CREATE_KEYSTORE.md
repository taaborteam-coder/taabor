# ✅ الأوامر الصحيحة لإنشاء Keystore على Windows

## افتح PowerShell كـ Administrator

```powershell
# 1. اذهب للمجلد
cd "C:\New folder\Desktop\Taabor\mobile_app\android\app"

# 2. أنشئ keystore
keytool -genkey -v -keystore taabor-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias taabor

# 3. حوّله لـ base64
certutil -encode taabor-release-key.jks keystore_base64.txt

# 4. افتح الملف
notepad keystore_base64.txt

# 5. تحقق من وجود الملف
Get-ChildItem *.jks

# 6. اعرض معلومات keystore
keytool -list -v -keystore taabor-release-key.jks
```

## نسخ محتوى Base64 بسرعة

```powershell
# انسخ المحتوى للـ clipboard مباشرة
Get-Content keystore_base64.txt | Set-Clipboard

# الآن اذهب لـ GitHub واعمل Paste!
```

## معلومات مهمة

**كلمة المرور:** اختر كلمة قوية واحفظها
**Alias:** taabor
**الملفات المُنشأة:**

- `taabor-release-key.jks` ← الأصلي (احفظه!)
- `keystore_base64.txt` ← للـ GitHub Secret

---

**جاهز؟** شغّل الأوامر وأرسل "تم" 🚀
