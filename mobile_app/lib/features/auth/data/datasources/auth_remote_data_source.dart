import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/logging/app_logger.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> requestPasswordReset(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._auth, this._firestore);

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      AppLogger.info('🔐 Remote: Attempting to sign in: $email');

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw ServerException('User not found after sign in');
      }

      await _ensureUserDocumentExists(credential.user!);

      final userDoc = await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw ServerException('User document does not exist');
      }

      return UserModel.fromFirestore(userDoc);
    } on firebase_auth.FirebaseAuthException catch (e) {
      AppLogger.error('❌ Firebase auth error: ${e.code}', e);
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw AuthException('invalid_credentials');
      } else if (e.code == 'too-many-requests') {
        throw AuthException('too_many_requests');
      } else if (e.code == 'network-request-failed') {
        throw NetworkException();
      }
      throw ServerException(e.message ?? 'Authentication failed');
    } catch (e) {
      AppLogger.error('❌ Unexpected error during sign in', e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      AppLogger.info('📝 Remote: Attempting to sign up: $email');

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _createUserDocument(credential.user!);
      }

      // Sign out after registration so user can login manually
      await _auth.signOut();
    } on firebase_auth.FirebaseAuthException catch (e) {
      AppLogger.error('❌ Firebase signup error: ${e.code}', e);
      if (e.code == 'email-already-in-use') {
        throw AuthException('email_already_in_use');
      } else if (e.code == 'weak-password') {
        throw AuthException('weak_password');
      } else if (e.code == 'invalid-email') {
        throw AuthException('invalid_email');
      } else if (e.code == 'network-request-failed') {
        throw NetworkException();
      }
      throw ServerException(e.message ?? 'Signup failed');
    } catch (e) {
      AppLogger.error('❌ Unexpected error during signup', e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromFirestore(doc);
        }
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<void> _createUserDocument(firebase_auth.User user) async {
    try {
      AppLogger.info('📄 Creating user document for: ${user.uid}');
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(UserModel.createNewUserMap(email: user.email ?? ''));
    } catch (e) {
      AppLogger.error('❌ Error creating user document', e);
      // We don't throw here to allow auth to proceed, but log it
    }
  }

  Future<void> _ensureUserDocumentExists(firebase_auth.User user) async {
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists) {
      await _createUserDocument(user);
    }
  }
}
