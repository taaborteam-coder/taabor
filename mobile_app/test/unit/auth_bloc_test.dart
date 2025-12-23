import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:taabor/core/error/failures.dart';
import 'package:taabor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taabor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taabor/features/auth/presentation/bloc/auth_state.dart';
import 'package:taabor/features/auth/domain/usecases/sign_in.dart';
import 'package:taabor/features/auth/domain/usecases/sign_up.dart';
import 'package:taabor/features/auth/domain/usecases/sign_out.dart';
import 'package:taabor/features/auth/domain/usecases/get_current_user.dart';
import 'package:taabor/features/auth/data/models/user_model.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([SignIn, SignUp, SignOut, GetCurrentUser])
void main() {
  late AuthBloc authBloc;
  late MockSignIn mockSignIn;
  late MockSignUp mockSignUp;
  late MockSignOut mockSignOut;
  late MockGetCurrentUser mockGetCurrentUser;

  const tUser = UserModel(
    id: 'user123',
    email: 'test@example.com',
    role: 'client',
    isVerified: false,
  );

  setUp(() {
    mockSignIn = MockSignIn();
    mockSignUp = MockSignUp();
    mockSignOut = MockSignOut();
    mockGetCurrentUser = MockGetCurrentUser();

    authBloc = AuthBloc(
      signIn: mockSignIn,
      signUp: mockSignUp,
      signOut: mockSignOut,
      getCurrentUser: mockGetCurrentUser,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, equals(AuthInitial()));
    });

    group('SignInRequested', () {
      test(
        'should emit [AuthLoading, AuthAuthenticated] when sign in is successful',
        () async {
          // Arrange
          when(
            mockSignIn(any, any),
          ).thenAnswer((_) async => const Right(tUser));

          // Assert later
          final expected = [AuthLoading(), const AuthAuthenticated(tUser)];
          expectLater(authBloc.stream, emitsInOrder(expected));

          // Act
          authBloc.add(
            const SignInRequested(email: testEmail, password: testPassword),
          );
        },
      );

      test('should emit [AuthLoading, AuthError] when sign in fails', () async {
        // Arrange
        when(
          mockSignIn(any, any),
        ).thenAnswer((_) async => Left(ServerFailure()));

        // Assert later
        final expected = [AuthLoading(), const AuthError('error_occurred')];
        expectLater(authBloc.stream, emitsInOrder(expected));

        // Act
        authBloc.add(
          const SignInRequested(email: testEmail, password: testPassword),
        );
      });
    });

    group('SignUpRequested', () {
      test(
        'should emit [AuthLoading, AuthUnauthenticated] when sign up is successful',
        () async {
          // Arrange
          when(mockSignUp(any, any)).thenAnswer((_) async => const Right(null));

          // Assert later
          final expected = [AuthLoading(), AuthUnauthenticated()];
          expectLater(authBloc.stream, emitsInOrder(expected));

          // Act
          authBloc.add(
            const SignUpRequested(email: testEmail, password: testPassword),
          );
        },
      );
    });

    group('SignOutRequested', () {
      test(
        'should emit [AuthLoading, AuthUnauthenticated] when sign out is successful',
        () async {
          // Arrange
          when(mockSignOut()).thenAnswer((_) async => const Right(null));

          // Assert later
          final expected = [AuthLoading(), AuthUnauthenticated()];
          expectLater(authBloc.stream, emitsInOrder(expected));

          // Act
          authBloc.add(SignOutRequested());
        },
      );
    });
  });
}
