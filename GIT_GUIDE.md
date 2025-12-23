# دليل Git Bash - مشروع Taabor

## 🚀 البدء السريع

### 1. استنساخ المشروع (Clone)

```bash
# استنساخ المشروع
git clone https://github.com/YOUR_USERNAME/taabor.git

# الانتقال للمجلد
cd taabor

# الانتقال لمجلد التطبيق
cd mobile_app
```

---

## 📦 إعداد المشروع

### تثبيت Dependencies

```bash
# تثبيت Flutter packages
flutter pub get

# تنظيف المشروع
flutter clean

# إعادة البناء
flutter pub get
```

---

## 🔧 العمل اليومي

### إنشاء Branch جديد

```bash
# إنشاء وتبديل لـ branch جديد
git checkout -b feature/your-feature-name

# أو للـ bug fix
git checkout -b fix/bug-description
```

### حفظ التغييرات (Commit)

```bash
# إضافة جميع الملفات المعدلة
git add .

# أو إضافة ملف محدد
git add path/to/file.dart

# عمل commit مع رسالة واضحة
git commit -m "feat: add user authentication feature"

# أمثلة لـ commit messages:
git commit -m "fix: resolve login crash on Android"
git commit -m "docs: update README with deployment guide"
git commit -m "test: add unit tests for AuthBloc"
git commit -m "refactor: improve queue service performance"
```

### رفع التغييرات (Push)

```bash
# Push للـ branch الحالي
git push origin feature/your-feature-name

# أول مرة push (set upstream)
git push -u origin feature/your-feature-name

# Force push (احذر - يحذف التاريخ!)
git push --force origin feature/your-feature-name
```

---

## 🔄 سحب التحديثات (Pull)

```bash
# سحب آخر تحديثات من main
git checkout main
git pull origin main

# دمج التحديثات في branch الخاص بك
git checkout feature/your-feature-name
git merge main

# أو استخدام rebase (أفضل للـ history نظيف)
git rebase main
```

---

## 🏷️ إصدار نسخة جديدة (Release)

### إنشاء Tag للإصدار

```bash
# التأكد من آخر تحديث
git checkout main
git pull origin main

# تحديث رقم الإصدار في pubspec.yaml
# version: 1.0.0+1

git add mobile_app/pubspec.yaml
git commit -m "chore: bump version to 1.0.0"

# إنشاء tag
git tag v1.0.0

# Push الـ tag (هذا يشغل CI/CD!)
git push origin main --tags
```

### عرض جميع Tags

```bash
# عرض Tags المحلية
git tag

# عرض Tags مع التفاصيل
git tag -n

# عرض Tags من Remote
git ls-remote --tags origin
```

### حذف Tag (إذا اخطأت)

```bash
# حذف tag محلي
git tag -d v1.0.0

# حذف tag من remote
git push --delete origin v1.0.0
```

---

## 🔍 فحص الحالة

```bash
# عرض حالة الملفات
git status

# عرض الفروقات
git diff

# عرض الفروقات لملف محدد
git diff path/to/file.dart

# عرض تاريخ الـ commits
git log --oneline --graph --all

# عرض آخر 10 commits
git log -10 --pretty=format:"%h - %an, %ar : %s"
```

---

## ⚠️ إصلاح الأخطاء

### التراجع عن التغييرات

```bash
# التراجع عن تعديلات ملف (قبل add)
git checkout -- path/to/file.dart

# التراجع عن جميع التعديلات
git checkout -- .

# إلغاء git add (قبل commit)
git reset HEAD path/to/file.dart

# أو إلغاء جميع الـ staged files
git reset HEAD .
```

### التراجع عن Commit

```bash
# التراجع عن آخر commit (الملفات تبقى staged)
git reset --soft HEAD~1

# التراجع عن آخرcommit (الملفات unstaged)
git reset HEAD~1

# التراجع الكامل (حذف التعديلات - احذر!)
git reset --hard HEAD~1
```

### حل Merge Conflicts

```bash
# عند ظهور conflict
git status  # لرؤية الملفات المتعارضة

# افتح الملف وحل التعارض يدوياً
# ابحث عن:
# <<<<<<< HEAD
# your changes
# =======
# incoming changes
# >>>>>>> branch-name

# بعد الحل
git add path/to/resolved-file.dart
git commit -m "fix: resolve merge conflict"
```

---

## 🧹 تنظيف المشروع

```bash
# حذف branches محلية تم دمجها
git branch --merged | grep -v "\*" | xargs -n 1 git branch -d

# حذف branch محلي
git branch -d feature/old-feature

# حذف branch من remote
git push origin --delete feature/old-feature

# تنظيف references قديمة
git fetch --prune

# حذف files غير مراقبة (untracked)
git clean -fd
```

---

## 🔐 إعداد SSH (أسرع من HTTPS)

```bash
# إنشاء SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# نسخ الـ public key
cat ~/.ssh/id_ed25519.pub | clip  # Windows
# أو
cat ~/.ssh/id_ed25519.pub  # Linux/Mac

# أضفه في GitHub: Settings → SSH Keys → New SSH key

# اختبار الاتصال
ssh -T git@github.com

# تغيير remote من HTTPS لـ SSH
git remote set-url origin git@github.com:YOUR_USERNAME/taabor.git
```

---

## 📊 Stash (حفظ مؤقت)

```bash
# حفظ التغييرات مؤقتاً
git stash

# حفظ مع وصف
git stash save "work in progress on feature X"

# عرض جميع الـ stashes
git stash list

# استرجاع آخر stash
git stash pop

# استرجاع stash محدد
git stash apply stash@{0}

# حذف stash
git stash drop stash@{0}

# حذف جميع stashes
git stash clear
```

---

## 🎯 Workflow مقترح

### للـ Features الجديدة

```bash
# 1. سحب آخر تحديثات
git checkout main
git pull origin main

# 2. إنشاء branch جديد
git checkout -b feature/awesome-feature

# 3. العمل على الكود...
# ... coding coding coding ...

# 4. الاختبار
flutter test
flutter analyze

# 5. Commit
git add .
git commit -m "feat: implement awesome feature"

# 6. Push
git push -u origin feature/awesome-feature

# 7. فتح Pull Request على GitHub

# 8. بعد الموافقة - دمج في main
git checkout main
git pull origin main
git branch -d feature/awesome-feature
```

### للإصدارات (Releases)

```bash
# 1. تأكد من نظافة main
git checkout main
git pull origin main
flutter test  # تأكد من نجاح الاختبارات

# 2. حدّث رقم الإصدار
# في pubspec.yaml: version: 1.0.0+1

# 3. Commit التحديث
git add mobile_app/pubspec.yaml
git commit -m "chore: bump version to 1.0.0"

# 4. إنشاء Tag
git tag -a v1.0.0 -m "Release version 1.0.0"

# 5. Push (CI/CD سيبدأ تلقائياً!)
git push origin main --tags

# 6. راقب GitHub Actions
# GitHub → Actions
```

---

## 🆘 أوامر الطوارئ

```bash
# نسيت التبديل لـ branch قبل التعديل؟
git stash
git checkout -b new-feature-branch
git stash pop

# عملت commit في main بدل feature branch؟
git reset --soft HEAD~1  # التراجع
git checkout -b feature/correct-branch
git commit -m "feat: correct commit"

# حذفت ملف بالخطأ؟
git checkout HEAD -- path/to/file.dart

# كل شيء خرب - العودة لآخر commit نظيف
git reset --hard HEAD
git clean -fd
```

---

## 📝 Git Aliases (اختصارات)

أضف هذه الاختصارات لـ `~/.gitconfig`:

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual 'log --oneline --graph --all --decorate'
```

الآن يمكنك استخدام:

```bash
git st        # بدل git status
git co main   # بدل git checkout main
git visual    # شجرة commits جميلة
```

---

## 🎓 نصائح مهمة

1. **Commit بانتظام** - أفضل من commit واحد ضخم
2. **اكتب رسائل واضحة** - استخدم `feat:`, `fix:`, `docs:`, إلخ...
3. **Pull قبل Push** - دائماً اسحب التحديثات أولاً
4. **Test قبل Commit** - `flutter test` قبل كل commit
5. **Branch لكل feature** - لا تعمل على main مباشرة
6. **Tags للإصدارات فقط** - v1.0.0, v1.0.1, إلخ...

---

## 🔗 روابط مفيدة

- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Docs](https://docs.github.com/)

---

**Happy Coding! 🚀**
