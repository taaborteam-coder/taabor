import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatEntity>> createChat(List<String> participants);
  Future<Either<Failure, void>> sendMessage(MessageEntity message);
  Future<Either<Failure, List<MessageEntity>>> getChatMessages(String chatId);
  Stream<List<MessageEntity>> streamChatMessages(String chatId);
  Future<Either<Failure, List<ChatEntity>>> getUserChats(String userId);
  Future<Either<Failure, void>> markAsRead(String chatId, String userId);
}
