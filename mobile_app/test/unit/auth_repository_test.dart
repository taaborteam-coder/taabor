import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:taabor/features/auth/data/models/user_model.dart';
import 'package:taabor/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taabor/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taabor/core/error/exceptions.dart';
import 'package:taabor/core/error/failures.dart';

@GenerateMocks([AuthRemoteDataSource])
import 'auth_repository_test.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockDataSource;

  const tUserModel = UserModel(
    id: 'user123',
    email: 'test@example.com',
    role: 'client',
    isVerified: false,
  );

  setUp(() {
    mockDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockDataSource);
  });

  group('AuthRepository', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    group('signIn', () {
      test('should return userId when sign in is successful', () async {
        // Arrange
        when(
          mockDataSource.signIn(any, any),
        ).thenAnswer((_) async => tUserModel);

        // Act
        final result = await repository.signIn(testEmail, testPassword);

        // Assert
        expect(result, const Right(tUserModel));
        verify(mockDataSource.signIn(testEmail, testPassword));
      });

      test(
        'should return ServerFailure when sign in throws ServerException',
        () async {
          // Arrange
          when(mockDataSource.signIn(any, any)).thenThrow(ServerException());

          // Act
          final result = await repository.signIn(testEmail, testPassword);

          // Assert
          expect(result, Left(ServerFailure()));
          verify(mockDataSource.signIn(testEmail, testPassword));
        },
      );
    });

    group('signUp', () {
      test('should return userId when sign up is successful', () async {
        // Arrange
        when(
          mockDataSource.signUp(any, any),
        ).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.signUp(testEmail, testPassword);

        // Assert
        expect(result, const Right(null));
        verify(mockDataSource.signUp(testEmail, testPassword));
      });

      test(
        'should return ServerFailure when sign up throws exception',
        () async {
          // Arrange
          when(mockDataSource.signUp(any, any)).thenThrow(ServerException());

          // Act
          final result = await repository.signUp(testEmail, testPassword);

          // Assert
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('signOut', () {
      test('should call data source sign out', () async {
        // Arrange
        when(mockDataSource.signOut()).thenAnswer((_) async => Future.value());

        // Act
        final result = await repository.signOut();

        // Assert
        expect(result, const Right(null));
        verify(mockDataSource.signOut());
      });
    });

    group('getCurrentUser', () {
      test('should return userId when user is authenticated', () async {
        // Arrange
        when(
          mockDataSource.getCurrentUser(),
        ).thenAnswer((_) async => tUserModel);

        // Act
        final result = await repository.getCurrentUser();

        // Assert
        expect(result, const Right(tUserModel));
        verify(mockDataSource.getCurrentUser());
      });

      test('should return null when user is not authenticated', () async {
        // Arrange
        when(mockDataSource.getCurrentUser()).thenAnswer((_) async => null);

        // Act
        final result = await repository.getCurrentUser();

        // Assert
        expect(result, const Right(null));
      });
    });
  });
}
