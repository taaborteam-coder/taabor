import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../models/chat_message_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(ChatMessageModel message);
  Stream<List<ChatMessageModel>> getMessages(
    String currentUserId,
    String otherUserId,
  );
  Future<String> getChatId(String userId1, String userId2);
}

class ChatRepositoryImpl implements ChatRepository {
  final FirebaseFirestore firestore;

  ChatRepositoryImpl({required this.firestore});

  @override
  Future<String> getChatId(String userId1, String userId2) async {
    // Basic chat ID generation logic: sort IDs to ensure consistency
    if (userId1.compareTo(userId2) < 0) {
      return '${userId1}_$userId2';
    } else {
      return '${userId2}_$userId1';
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage(ChatMessageModel message) async {
    try {
      final chatId = await getChatId(message.senderId, message.receiverId);
      final chatRef = firestore.collection('chats').doc(chatId);

      // Add message to subcollection
      await chatRef.collection('messages').add(message.toMap());

      // Update last message in main doc (optional, for list view)
      await chatRef.set({
        'lastMessage': message.text,
        'lastMessageTime': Timestamp.fromDate(message.timestamp),
        'participants': [message.senderId, message.receiverId],
      }, SetOptions(merge: true));

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<List<ChatMessageModel>> getMessages(
    String currentUserId,
    String otherUserId,
  ) async* {
    final chatId = await getChatId(currentUserId, otherUserId);
    yield* firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ChatMessageModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }
}
