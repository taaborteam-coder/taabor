import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_data_source.dart';
import '../models/payment_model.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaymentEntity>> createPayment({
    required String userId,
    required String bookingId,
    required double amount,
    required PaymentMethod method,
  }) async {
    try {
      final payment = PaymentModel(
        id: '',
        userId: userId,
        bookingId: bookingId,
        amount: amount,
        method: method,
        status: PaymentStatus.pending,
        createdAt: DateTime.now(),
      );
      final result = await remoteDataSource.createPayment(payment);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentEntity>> processPayment(
    String paymentId,
  ) async {
    try {
      final result = await remoteDataSource.processPayment(paymentId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PaymentEntity>>> getUserPayments(
    String userId,
  ) async {
    try {
      final result = await remoteDataSource.getUserPayments(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PaymentEntity>> getPaymentById(
    String paymentId,
  ) async {
    try {
      final result = await remoteDataSource.getPaymentById(paymentId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> refundPayment(String paymentId) async {
    try {
      await remoteDataSource.refundPayment(paymentId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
