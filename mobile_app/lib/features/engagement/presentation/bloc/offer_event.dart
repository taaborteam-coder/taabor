import 'package:equatable/equatable.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class GetActiveOffersEvent extends OfferEvent {
  final String businessId;

  const GetActiveOffersEvent(this.businessId);

  @override
  List<Object> get props => [businessId];
}
