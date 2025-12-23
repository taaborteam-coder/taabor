import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/search_filters.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchFiltersChanged>(_onSearchFiltersChanged);
    on<ClearSearch>(_onClearSearch);
  }

  final List<String> _mockBusinesses = [
    'Barber Shop 1',
    'Salon Deluxe',
    'Dentist Clinic',
    'Car Wash Express',
    'Burger Joint',
    'Gym Pro',
  ];

  void _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchLoading());
    final results = _performSearch(event.query, null);
    emit(SearchLoaded(results, event.query));
  }

  void _onSearchFiltersChanged(
    SearchFiltersChanged event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchLoading());
    // In a real app, we would use the current query. For now, assuming empty query or storing it.
    // For simplicity, we are just returning results based on filters (mock)
    final results = _performSearch('', event.filters);
    emit(SearchLoaded(results, '', filters: event.filters));
  }

  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    emit(SearchInitial());
  }

  List<String> _performSearch(String query, SearchFilters? filters) {
    return _mockBusinesses.where((name) {
      final matchesQuery = name.toLowerCase().contains(query.toLowerCase());
      // Mock filter logic
      final matchesCategory =
          filters?.category == null ||
          filters!.category == 'All' ||
          name.contains(filters.category!);
      return matchesQuery && matchesCategory;
    }).toList();
  }
}
