import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.role,
    required super.isVerified,
    super.displayName,
    super.phoneNumber,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      role: data['role'] ?? 'client',
      isVerified: data['isVerified'] ?? false,
      displayName: data['displayName'],
      phoneNumber: data['phoneNumber'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'role': role,
      'isVerified': isVerified,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  // Create user data for registration
  static Map<String, dynamic> createNewUserMap({
    required String email,
    String role = 'client',
    String? displayName,
  }) {
    return {
      'email': email,
      'role': role,
      'isVerified': false,
      'displayName': displayName ?? email.split('@')[0],
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
