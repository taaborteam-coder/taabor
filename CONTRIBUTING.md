# Contributing to Taabor

شكراً لاهتمامك بالمساهمة في Taabor! 🎉

## 🚀 البدء

### المتطلبات

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Git
- محرر نصوص (VS Code موصى به)

### إعداد البيئة المحلية

```bash
# 1. Fork المشروع
git clone https://github.com/YOUR_USERNAME/taabor.git
cd taabor/mobile_app

# 2. تثبيت الحزم
flutter pub get

# 3. تشغيل التطبيق
flutter run -d windows
```

## 📝 إرشادات المساهمة

### 1. Code Style

نتبع [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines:

```dart
// ✅ Good
class UserRepository {
  Future<User> getUser(String id) async {
    // ...
  }
}

// ❌ Bad
class userRepository {
  getUser(id) {
    // ...
  }
}
```

### 2. Clean Architecture

المشروع مبني على Clean Architecture:

```text
feature/
├── domain/     # Business logic
├── data/       # Data layer
└── presentation/  # UI layer
```

### 3. Testing

كل كود جديد يجب أن يحتوي على اختبارات:

```bash
# تشغيل الاختبارات
flutter test

# مع التغطية
flutter test --coverage
```

**متطلبات التغطية:**

- Use Cases: 80%+
- BLoCs: 90%+
- Critical paths: 100%

### 4. Commit Messages

نستخدم [Conventional Commits](https://www.conventionalcommits.org/):

```text
feat: add user profile page
fix: resolve login authentication bug
docs: update README with installation steps
test: add unit tests for SignIn use case
refactor: improve queue bloc structure
```

**Types:**

- `feat`: ميزة جديدة
- `fix`: إصلاح bug
- `docs`: تحديث التوثيق
- `test`: إضافة/تعديل اختبارات
- `refactor`: إعادة هيكلة الكود
- `style`: تنسيق الكود
- `chore`: مهام صيانة

### 5. Pull Request Process

1. **إنشاء Branch جديد**

   ```bash
   git checkout -b feat/your-feature-name
   ```

2. **عمل Commit للتغييرات**

   ```bash
   git add .
   git commit -m "feat: add amazing feature"
   ```

3. **Push إلى GitHub**

   ```bash
   git push origin feat/your-feature-name
   ```

4. **فتح Pull Request**
   - عنوان واضح ومختصر
   - وصف مفصل للتغييرات
   - screenshots إذا كانت تغييرات UI
   - ربط بـ Issue ذات صلة

### 6. PR Checklist

قبل فتح PR، تأكد من:

- [ ] الكود يتبع Style Guide
- [ ] الاختبارات تعمل (`flutter test`)
- [ ] لا توجد lint errors (`flutter analyze`)
- [ ] الكود منسق (`dart format .`)
- [ ] التوثيق محدّث
- [ ] Commit messages صحيحة

## 🐛 الإبلاغ عن Bug

استخدم GitHub Issues مع template التالي:

```markdown
**الوصف:**
وصف واضح للمشكلة

**خطوات إعادة المشكلة:**
1. افتح الصفحة X
2. اضغط على Y
3. لاحظ الخطأ

**السلوك المتوقع:**
ماذا كنت تتوقع أن يحدث

**Screenshots:**
إن وجدت

**البيئة:**
- OS: Windows 11 / macOS / Linux
- Flutter version: 3.24.0
- Device: Desktop / Android / iOS
```

## 💡 اقتراح ميزة جديدة

افتح GitHub Issue مع:

- وصف المشكلة التي تحلها الميزة
- الحل المقترح
- بدائل أخرى تم النظر فيها
- سياق إضافي أو screenshots

## 🏗️ Architecture Guidelines

### Domain Layer

```dart
// Entity - Domain entity (plain Dart)
class User extends Equatable {
  final String id;
  const User({required this.id});
  @override
  List<Object> get props => [id];
}

// Repository Interface
abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
}

// Use Case
class GetUser {
  final UserRepository repository;
  GetUser(this.repository);
  
  Future<Either<Failure, User>> call(String id) {
    return repository.getUser(id);
  }
}
```

### Data Layer

```dart
// Model - extends Entity
class UserModel extends User {
  const UserModel({required super.id});
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id']);
  }
}

// Repository Implementation
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  
  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final user = await remoteDataSource.getUser(id);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
```

### Presentation Layer

```dart
// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;
  
  UserBloc({required this.getUser}) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUser);
  }
  
  Future<void> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final result = await getUser(event.userId);
    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }
}
```

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## ❓ الأسئلة

إذا كان لديك أسئلة، يمكنك:

- فتح GitHub Discussion
- التواصل عبر Issues
- مراسلة المشرفين

---

شكراً لمساهمتك! 🙏
