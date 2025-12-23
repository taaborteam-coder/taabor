import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:taabor/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taabor/features/auth/presentation/bloc/auth_event.dart';
import 'package:taabor/features/auth/presentation/bloc/auth_state.dart';
import 'package:taabor/features/auth/domain/usecases/sign_in.dart';
import 'package:taabor/features/auth/domain/usecases/sign_up.dart';
import 'package:taabor/features/auth/domain/usecases/sign_out.dart';
import 'package:taabor/features/auth/domain/usecases/get_current_user.dart';
import 'package:taabor/features/auth/domain/entities/user.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockSignOut extends Mock implements SignOut {}

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

void main() {
  late AuthBloc authBloc;
  late MockSignIn mockSignIn;
  late MockSignUp mockSignUp;
  late MockSignOut mockSignOut;
  late MockGetCurrentUser mockGetCurrentUser;

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

  const tUser = User(
    id: '1',
    email: 'test@example.com',
    displayName: 'Test User',
    role: 'user',
    isVerified: true,
  );

  test('initial state should be AuthInitial', () {
    expect(authBloc.state, isA<AuthInitial>());
  });

  blocTest<AuthBloc, AuthState>(
    'emits [AuthAuthenticated] when AuthCheckRequested is added and user is logged in',
    build: () {
      when(
        () => mockGetCurrentUser(),
      ).thenAnswer((_) async => const Right(tUser));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthCheckRequested()),
    expect: () => [AuthLoading(), const AuthAuthenticated(tUser)],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthUnauthenticated] when AuthCheckRequested is added and user is null',
    build: () {
      when(
        () => mockGetCurrentUser(),
      ).thenAnswer((_) async => const Right(null));
      return authBloc;
    },
    act: (bloc) => bloc.add(AuthCheckRequested()),
    expect: () => [AuthLoading(), AuthUnauthenticated()],
  );
}
