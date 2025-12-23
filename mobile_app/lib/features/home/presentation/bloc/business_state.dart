import 'package:equatable/equatable.dart';
import '../../domain/entities/business.dart';
import '../../domain/entities/service.dart';

abstract class BusinessState extends Equatable {
  const BusinessState();

  @override
  List<Object?> get props => [];
}

class BusinessInitial extends BusinessState {}

class BusinessLoading extends BusinessState {}

class BusinessesLoaded extends BusinessState {
  final List<Business> businesses;

  const BusinessesLoaded(this.businesses);

  @override
  List<Object> get props => [businesses];
}

class ServicesLoaded extends BusinessState {
  final List<Service> services;

  const ServicesLoaded(this.services);

  @override
  List<Object> get props => [services];
}

class BusinessError extends BusinessState {
  final String message;

  const BusinessError(this.message);

  @override
  List<Object> get props => [message];
}
