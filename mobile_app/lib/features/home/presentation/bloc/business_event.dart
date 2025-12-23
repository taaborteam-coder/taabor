import 'package:equatable/equatable.dart';

abstract class BusinessEvent extends Equatable {
  const BusinessEvent();

  @override
  List<Object> get props => [];
}

class GetBusinessesEvent extends BusinessEvent {}

class GetServicesEvent extends BusinessEvent {
  final String businessId;

  const GetServicesEvent(this.businessId);

  @override
  List<Object> get props => [businessId];
}
