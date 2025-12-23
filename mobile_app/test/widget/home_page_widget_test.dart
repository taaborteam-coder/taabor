import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:taabor/features/home/presentation/bloc/business_bloc.dart';
import 'package:taabor/features/home/presentation/bloc/business_state.dart';
import 'package:taabor/features/home/presentation/pages/home_page.dart'; // Contains HomePageView
import 'package:taabor/features/home/data/models/business_model.dart';
import 'package:taabor/core/providers/theme_provider.dart';

@GenerateMocks([BusinessBloc, ThemeProvider])
import 'home_page_widget_test.mocks.dart';

void main() {
  late MockBusinessBloc mockBusinessBloc;
  late MockThemeProvider mockThemeProvider;

  setUp(() {
    mockBusinessBloc = MockBusinessBloc();
    mockThemeProvider = MockThemeProvider();
    // Setup default stub for ThemeProvider
    when(mockThemeProvider.isDarkMode).thenReturn(false);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>.value(value: mockThemeProvider),
          BlocProvider<BusinessBloc>.value(value: mockBusinessBloc),
        ],
        child: const HomePageView(),
      ),
    );
  }

  group('HomePage Widget Tests', () {
    testWidgets('should display loading indicator when state is loading', (
      tester,
    ) async {
      // Arrange
      when(mockBusinessBloc.state).thenReturn(BusinessLoading());
      when(mockBusinessBloc.stream).thenAnswer((_) => const Stream.empty());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('should display error message when state is error', (
      tester,
    ) async {
      // Arrange
      const errorMessage = 'Failed to load businesses';
      when(
        mockBusinessBloc.state,
      ).thenReturn(const BusinessError(errorMessage));
      when(mockBusinessBloc.stream).thenAnswer((_) => const Stream.empty());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.textContaining(errorMessage), findsOneWidget);
    });

    testWidgets('should display business list when state is loaded', (
      tester,
    ) async {
      // Arrange
      final businesses = [
        const BusinessModel(
          id: '1',
          name: 'Test Business 1',
          category: 'Restaurant',
          address: 'Test Address',
          imageUrl: '',
          rating: 4.5,
          isOpen: true,
          currentQueueLength: 2,
          estimatedWaitTimeMinutes: 15,
          phoneNumber: '123',
          latitude: 0.0,
          longitude: 0.0,
        ),
        const BusinessModel(
          id: '2',
          name: 'Test Business 2',
          category: 'Salon',
          address: 'Test Address 2',
          imageUrl: '',
          rating: 4.8,
          isOpen: false,
          currentQueueLength: 0,
          estimatedWaitTimeMinutes: 0,
          phoneNumber: '456',
          latitude: 0.0,
          longitude: 0.0,
        ),
      ];
      when(mockBusinessBloc.state).thenReturn(BusinessesLoaded(businesses));
      when(mockBusinessBloc.stream).thenAnswer((_) => const Stream.empty());

      // Act
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text('Test Business 1'), findsOneWidget);
      expect(find.text('Test Business 2'), findsOneWidget);
    });
  });
}
