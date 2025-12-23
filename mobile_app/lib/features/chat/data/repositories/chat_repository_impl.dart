import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/chat_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ChatEntity>> createChat(
    List<String> participants,
  ) async {
    try {
      final result = await remoteDataSource.createChat(participants);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(MessageEntity message) async {
    try {
      final messageModel = MessageModel(
        id: message.id,
        chatId: message.chatId,
        senderId: message.senderId,
        senderName: message.senderName,
        content: message.content,
        type: message.type,
        timestamp: message.timestamp,
        isRead: message.isRead,
        imageUrl: message.imageUrl,
        fileUrl: message.fileUrl,
      );
      await remoteDataSource.sendMessage(messageModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getChatMessages(
    String chatId,
  ) async {
    try {
      final result = await remoteDataSource.getChatMessages(chatId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Stream<List<MessageEntity>> streamChatMessages(String chatId) {
    return remoteDataSource.streamChatMessages(chatId);
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getUserChats(String userId) async {
    try {
      final result = await remoteDataSource.getUserChats(userId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String chatId, String userId) async {
    try {
      await remoteDataSource.markAsRead(chatId, userId);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
