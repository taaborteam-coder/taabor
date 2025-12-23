# Performance Optimization Guide

## 🚀 Performance Best Practices

### 1. Image Optimization

#### Use Cached Network Images

```dart
// Instead of Image.network()
CachedNetworkImage(
  imageUrl: business.imageUrl,
  placeholder: (context, url) => LoadingIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  memCacheWidth: 200,  // Resize for memory efficiency
)
```

### 2. List Performance

#### Use ListView.builder

```dart
// ✅ Good - Lazy loading
ListView.builder(
  itemCount: businesses.length,
  itemBuilder: (context, index) => BusinessCard(businesses[index]),
)

// ❌ Bad - Loads everything
ListView(
  children: businesses.map((b) => BusinessCard(b)).toList(),
)
```

#### Implement Pagination

```dart
class PaginatedList extends StatefulWidget {
  @override
  State<PaginatedList> createState() => _PaginatedListState();
}

class _PaginatedListState extends State<PaginatedList> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.8) {
      // Load more items
      context.read<BusinessBloc>().add(LoadMoreBusinesses());
    }
  }
}
```

### 3. State Management

#### Minimize Rebuilds

```dart
// Use const constructors
const BusinessCard({required this.business});

// Use BlocBuilder selectively
BlocBuilder<BusinessBloc, BusinessState>(
  buildWhen: (previous, current) => previous.businesses != current.businesses,
  builder: (context, state) => /* ... */,
)
```

### 4. Asset Optimization

#### Compress Images

- Use WebP format
- Provide multiple resolutions (@2x, @3x)
- Max size: 1MB per image

#### Lazy Load Assets

```dart
precacheImage(
  NetworkImage(business.imageUrl),
  context,
);
```

### 5. Database Queries

#### Index Firestore Queries

```javascript
// Create indexes for common queries
db.collection('businesses')
  .where('isOpen', '==', true)
  .where('category', '==', 'salon')
  .orderBy('rating', 'desc')
```

#### Limit Query Results

```dart
await FirebaseFirestore.instance
  .collection('businesses')
  .limit(20)  // Don't load everything
  .get();
```

### 6. Network Optimization

#### Implement Caching

```dart
class CachedRepository {
  final Map<String, CachedData> _cache = {};
  final Duration cacheValidity = Duration(minutes: 5);
  
  Future<List<Business>> getBusinesses() async {
    final cached = _cache['businesses'];
    if (cached != null && !cached.isExpired) {
      return cached.data;
    }
    
    final data = await _remoteDataSource.getBusinesses();
    _cache['businesses'] = CachedData(data, DateTime.now());
    return data;
  }
}
```

### 7. Build Optimization

#### Use const Widgets

```dart
// ✅ Good
const Text('Hello')

// ❌ Bad
Text('Hello')
```

#### Extract Widgets

```dart
// Instead of inline widgets
Widget build(BuildContext context) {
  return Column(
    children: [
      _buildHeader(),  // Extracted
      _buildBody(),
      _buildFooter(),
    ],
  );
}
```

### 8. Memory Management

#### Dispose Controllers

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  void dispose() {
    _controller.dispose();  // Always dispose!
    super.dispose();
  }
}
```

### 9. Animation Performance

#### Use AnimatedBuilder

```dart
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) => Transform.scale(
    scale: _controller.value,
    child: child,
  ),
  child: const Icon(Icons.star),  // Child doesn't rebuild
)
```

### 10. Monitoring

#### Track Performance

```dart
import 'package:taabor/core/utils/logger.dart';

Future<void> loadData() async {
  PerformanceMonitor.start('load_businesses');
  
  final businesses = await repository.getBusinesses();
  
  PerformanceMonitor.stop('load_businesses');
  return businesses;
}
```

## 📊 Performance Metrics

### Target Metrics

- **App startup**: < 2 seconds
- **Screen transition**: < 300ms
- **API calls**: < 1 second
- **Image loading**: < 500ms
- **List scrolling**: 60 FPS

### Measuring Performance

```bash
# Run with performance overlay
flutter run --profile

# Analyze build size
flutter build apk --analyze-size

# Profile memory
flutter run --profile --trace-startup
```

## 🔍 Tools

### Flutter DevTools

- Performance overlay
- Memory profiler
- Network profiler
- Widget inspector

### Firebase Performance Monitoring

```dart
final trace = FirebasePerformance.instance.newTrace('load_businesses');
await trace.start();
// ... operation
await trace.stop();
```

---

**Remember**: Premature optimization is the root of all evil. Profile first, then optimize!
