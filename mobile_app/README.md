# Taabor Mobile App

تطبيق Taabor لإدارة الطوابير والحجوزات في المحلات التجارية

## 🏗️ البنية المعمارية

يتبع المشروع **Clean Architecture** مع **BLoC Pattern** لإدارة الحالات.

### الطبقات الثلاث

```text
lib/
├── features/           # الميزات
│   ├── auth/          # المصادقة
│   ├── queue/         # إدارة الطوابير
│   ├── home/          # المحلات والخدمات
│   └── engagement/    # العروض والولاء
│       
├── core/              # الوظائف المشتركة
│   ├── di/           # Dependency Injection
│   ├── error/        # معالجة الأخطاء
│   └── localization/ # الترجمة
```

### هيكل كل ميزة

```text
feature/
├── domain/              # طبقة الأعمال
│   ├── entities/       # الكيانات
│   ├── repositories/   # واجهات المستودعات
│   └── usecases/       # حالات الاستخدام
│
├── data/               # طبقة البيانات
│   ├── models/        # نماذج البيانات
│   ├── datasources/   # مصادر البيانات
│   └── repositories/  # تطبيق المستودعات
│
└── presentation/       # طبقة العرض
    ├── bloc/          # إدارة الحالات
    ├── pages/         # الصفحات
    └── widgets/       # المكونات
```

## ✨ الميزات المنجزة

### 1️⃣ Auth - المصادقة

- ✅ تسجيل الدخول
- ✅ إنشاء حساب
- ✅ تسجيل الخروج
- ✅ معرفة المستخدم الحالي

### 2️⃣ Queue - إدارة الطوابير

- ✅ عرض التذاكر في الوقت الفعلي (Real-time Streams)
- ✅ إنشاء تذكرة جديدة
- ✅ تحديث حالة التذكرة
- ✅ إدارة أعمال صاحب المحل

### 3️⃣ Business - المحلات

- ✅ عرض قائمة المحلات القريبة
- ✅ تفاصيل المحل
- ✅ الخدمات المتاحة
- ✅ التقييمات

### 4️⃣ Offers - العروض

- ✅ عرض العروض النشطة
- ✅ إنشاء وتعديل العروض
- ✅ أنواع الخصم (نسبة، ثابت، هدية)
- ✅ تواريخ الصلاحية

### 5️⃣ Map - الخريطة

- ✅ عرض المحلات على الخريطة
- 🔜 تكامل Google Maps

## 🛠️ التقنيات المستخدمة

### Frontend

- **Flutter** - Framework
- **BLoC** - State Management
- **GetIt** - Dependency Injection
- **Dartz** - Functional Programming (Either/Failure)
- **Equatable** - Value Equality

### Backend

- **Firebase Auth** - المصادقة
- **Cloud Firestore** - قاعدة البيانات
- **Firebase Storage** - تخزين الملفات

## 🚀 البدء

### المتطلبات

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- Firebase Project

### التثبيت

```bash
# 1. استنساخ المشروع
git clone https://github.com/your-repo/taabor-app.git
cd taabor-app/mobile_app

# 2. تثبيت الحزم
flutter pub get

# 3. تشغيل التطبيق
flutter run -d windows  # أو android/ios
```

### إعداد Firebase

1. أنشئ مشروع Firebase
2. أضف ملف `google-services.json` (Android)
3. أضف ملف `GoogleService-Info.plist` (iOS)
4. فعّل Authentication و Firestore

## 📂 البيانات في Firestore

### Collections الرئيسية

```javascript
// users
{
  "uid": "string",
  "email": "string",
  "name": "string",
  "role": "customer|business_owner",
  "createdAt": timestamp
}

// businesses
{
  "id": "string",
  "name": "string",
  "category": "string",
  "address": "string",
  "isOpen": boolean,
  "rating": number
}

// tickets
{
  "id": "string",
  "businessId": "string",
  "userId": "string",
  "serviceId": "string",
  "status": "waiting|in_progress|completed|cancelled",
  "queueNumber": number,
  "createdAt": timestamp
}

// offers
{
  "id": "string",
  "businessId": "string",
  "title": "string",
  "discountType": "percentage|fixed|freebie",
  "discountValue": number,
  "validFrom": timestamp,
  "validTo": timestamp,
  "isActive": boolean
}
```

## 🧪 الاختبار

```bash
# Unit Tests
flutter test

# Widget Tests
flutter test test/widget_test.dart

# Integration Tests
flutter drive --target=test_driver/app.dart
```

## 📱 الشاشات الرئيسية

1. **Login** - شاشة تسجيل الدخول
2. **Register** - إنشاء حساب جديد
3. **Home** - قائمة المحلات
4. **Business Details** - تفاصيل المحل والحجز
5. **Ticket Status** - حالة التذكرة
6. **Business Dashboard** - لوحة تحكم صاحب المحل
7. **Offers** - العروض والخصومات

## 🔧 البناء للإنتاج

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Windows

```bash
flutter build windows --release
```

## 📝 الترخيص

هذا المشروع مرخص تحت رخصة MIT

## 👥 المساهمة

المساهمات مرحب بها! يرجى:

1. عمل Fork للمشروع
2. إنشاء Branch جديد
3. Commit التغييرات
4. Push إلى الـ Branch
5. فتح Pull Request

## 📞 التواصل

للاستفسارات والدعم، يرجى التواصل على:

- Email: <support@taabor.com>
- Website: <https://taabor.com>

---

Made with ❤️ using Flutter & Clean Architecture
