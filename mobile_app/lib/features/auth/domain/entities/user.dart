import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final String? displayName;
  final String? phoneNumber;

  const User({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    this.displayName,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    role,
    isVerified,
    displayName,
    phoneNumber,
  ];
}
