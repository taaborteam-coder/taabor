import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_business_services.dart';
import '../../domain/usecases/get_businesses.dart';
import 'business_event.dart';
import 'business_state.dart';

class BusinessBloc extends Bloc<BusinessEvent, BusinessState> {
  final GetBusinesses getBusinesses;
  final GetBusinessServices getBusinessServices;

  BusinessBloc({required this.getBusinesses, required this.getBusinessServices})
    : super(BusinessInitial()) {
    on<GetBusinessesEvent>(_onGetBusinesses);
    on<GetServicesEvent>(_onGetServices);
  }

  Future<void> _onGetBusinesses(
    GetBusinessesEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    final result = await getBusinesses();
    result.fold(
      (failure) => emit(BusinessError(failure.message)),
      (businesses) => emit(BusinessesLoaded(businesses)),
    );
  }

  Future<void> _onGetServices(
    GetServicesEvent event,
    Emitter<BusinessState> emit,
  ) async {
    emit(BusinessLoading());
    final result = await getBusinessServices(event.businessId);
    result.fold(
      (failure) => emit(BusinessError(failure.message)),
      (services) => emit(ServicesLoaded(services)),
    );
  }
}
