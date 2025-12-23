import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_active_offers.dart';
import 'offer_event.dart';
import 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final GetActiveOffers getActiveOffers;

  OfferBloc({required this.getActiveOffers}) : super(OfferInitial()) {
    on<GetActiveOffersEvent>(_onGetActiveOffers);
  }

  Future<void> _onGetActiveOffers(
    GetActiveOffersEvent event,
    Emitter<OfferState> emit,
  ) async {
    emit(OfferLoading());
    final result = await getActiveOffers(event.businessId);
    result.fold(
      (failure) => emit(OfferError(failure.message)),
      (offers) => emit(OffersLoaded(offers)),
    );
  }
}
