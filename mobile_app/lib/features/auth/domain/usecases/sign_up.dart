import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<Either<Failure, void>> call(String email, String password) async {
    return await repository.signUp(email, password);
  }
}
