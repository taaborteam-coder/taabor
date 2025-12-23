# Performance Optimization Guide - Taabor

## Overview

This guide covers performance optimization strategies for the Taabor mobile application.

## Image Optimization

### Image Caching

```dart
// Using cached_network_image
CachedNetworkImage(
  imageUrl: business.imageUrl,
  placeholder: (context, url) => ShimmerWidget(...),
  errorWidget: (context, url, error) => Icon(Icons.error),
  cacheManager: CacheManager(
    Config(
      'taabor_images',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  ),
);
```

### Image Compression

- Use WebP format for web/Android
- Use appropriate resolutions (avoid loading 4K images for thumbnails)
- Implement lazy loading for image lists

## List Performance

### Pagination

```dart
// Firestore pagination
Query query = firestore
    .collection('businesses')
    .orderBy('name')
    .limit(20);

// Next page
query = query.startAfterDocument(lastDocument);
```

### Lazy Loading with ListView.builder

```dart
ListView.builder(
  itemCount: businesses.length,
  itemBuilder: (context, index) {
    // Only builds visible items
    return BusinessCard(business: businesses[index]);
  },
);
```

### Infinite Scroll

```dart
class _BusinessListState extends State<BusinessList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      // Load more when 90% scrolled
      _loadMoreBusinesses();
    }
  }
}
```

## Firestore Optimization

### Query Optimization

```dart
// BAD: Reading entire collection
final allBusinesses = await firestore.collection('businesses').get();

// GOOD: Filter on server
final nearbyBusinesses = await firestore
    .collection('businesses')
    .where('latitude', isGreaterThan: minLat)
    .where('latitude', isLessThan: maxLat)
    .limit(20)
    .get();
```

### Composite Indexes

Create indexes for common queries in `firestore.indexes.json`:

```json
{
  "indexes": [
    {
      "collectionGroup": "tickets",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "businessId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

### Data Denormalization

```dart
// Instead of separate reads:
final business = await getBusinessById(ticket.businessId);
final user = await getUserById(ticket.userId);

// Store commonly accessed fields together:
class Ticket {
  final String id;
  final String businessId;
  final String businessName; // Denormalized
  final String userId;
  final String userName; // Denormalized
}
```

## State Management

### Avoid Rebuilding Entire UI

```dart
// BAD: Rebuilds everything
BlocBuilder<BusinessBloc, BusinessState>(
  builder: (context, state) {
    return EntireHomePage(state: state);
  },
);

// GOOD: Only rebuild what changes
Column(
  children: [
    StaticHeader(),
    BlocBuilder<BusinessBloc, BusinessState>(
      builder: (context, state) {
        return BusinessList(businesses: state.businesses);
      },
    ),
  ],
)
```

### Use const Widgets

```dart
// const widgets are cached
const EmptyState(
  icon: Icons.inbox,
  title: 'No Items',
  message: 'Add your first item',
)
```

## Memory Management

### Dispose Resources

```dart
class _MyPageState extends State<MyPage> {
  late StreamSubscription _subscription;
  late AnimationController _controller;

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }
}
```

### Limit Stream Listeners

```dart
// Use StreamBuilder instead of manual listeners
StreamBuilder<List<Ticket>>(
  stream: ticketStream,
  builder: (context, snapshot) {
    // UI updates automatically
  },
)
```

## Network Optimization

### Batch Requests

```dart
// BAD: Multiple separate requests
for (final ticketId in ticketIds) {
  await getTicket(ticketId);
}

// GOOD: Single batch request
final tickets = await firestore
    .collection('tickets')
    .where(FieldPath.documentId, whereIn: ticketIds)
    .get();
```

### Offline First

```dart
// Enable offline persistence
FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true,
  cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
);
```

## Animation Performance

### Use Hardware Acceleration

```dart
// Enable RepaintBoundary for complex widgets
RepaintBoundary(
  child: ComplexWidget(),
)
```

### Optimize Animation Builders

```dart
// Use AnimatedBuilder instead of setState
AnimatedBuilder(
  animation: _controller,
  builder: (context, child) {
    return Transform.scale(
      scale: _animation.value,
      child: child,
    );
  },
  child: const ExpensiveWidget(), // Built once
)
```

## Build Performance

### Use release mode for testing

```bash
flutter build apk --release
flutter build ios --release
```

### Enable code shrinking

```gradle
// android/app/build.gradle
buildTypes {
    release {
        minifyEnabled true
        shrinkResources true
    }
}
```

## Monitoring

### Performance Profiling

```dart
// Wrap expensive operations
await FirebaseMonitoringService.tracePerformance(
  traceName: 'load_businesses',
  operation: () async {
    return await getBusinesses();
  },
);
```

### FPS Monitoring

```bash
flutter run --profile
# Open DevTools performance tab
```

## Benchmarks

Target performance metrics:

- **App Startup**: < 2 seconds
- **List Scroll**: 60 FPS
- **Navigation**: < 300ms
- **API Response**: < 1 second
- **Image Load**: < 500ms

## Performance Checklist

- [ ] Images cached and compressed
- [ ] Lists use ListView.builder
- [ ] Pagination implemented
- [ ] Firestore queries optimized
- [ ] Indexes created for common queries
- [ ] Unnecessary rebuilds eliminated
- [ ] Resources properly disposed
- [ ] Offline mode enabled
- [ ] Animations use hardware acceleration
- [ ] Release builds tested
- [ ] Performance monitoring enabled

## Tools

- **Flutter DevTools**: Performance profiling
- **Firebase Performance**: Real-world metrics
- **Android Profiler**: Memory and CPU analysis
- **Xcode Instruments**: iOS performance
