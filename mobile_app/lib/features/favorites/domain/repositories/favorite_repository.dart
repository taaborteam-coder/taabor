import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/favorite.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addFavorite(String userId, String businessId);
  Future<Either<Failure, void>> removeFavorite(
    String userId,
    String businessId,
  );
  Future<Either<Failure, List<FavoriteEntity>>> getUserFavorites(String userId);
  Future<Either<Failure, bool>> isFavorite(String userId, String businessId);
  Stream<List<FavoriteEntity>> streamUserFavorites(String userId);
}
