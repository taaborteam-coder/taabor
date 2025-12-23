import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatModel> createChat(List<String> participants);
  Future<void> sendMessage(MessageModel message);
  Future<List<MessageModel>> getChatMessages(String chatId);
  Stream<List<MessageModel>> streamChatMessages(String chatId);
  Future<List<ChatModel>> getUserChats(String userId);
  Future<void> markAsRead(String chatId, String userId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImpl({required this.firestore});

  @override
  Future<ChatModel> createChat(List<String> participants) async {
    // Check if chat already exists
    final query = await firestore
        .collection('chats')
        .where('participants', arrayContainsAny: participants)
        .get();

    // Simple check - in production need better logic for implementation
    for (var doc in query.docs) {
      final data = doc.data();
      final existingParticipants = List<String>.from(data['participants']);
      if (existingParticipants.length == participants.length &&
          existingParticipants.every((p) => participants.contains(p))) {
        return ChatModel.fromFirestore(doc);
      }
    }

    final docRef = await firestore.collection('chats').add({
      'participants': participants,
      'createdAt': FieldValue.serverTimestamp(),
      'unreadCount': 0,
    });

    final doc = await docRef.get();
    return ChatModel.fromFirestore(doc);
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    final batch = firestore.batch();

    // 1. Add message
    final messageRef = firestore.collection('messages').doc();
    batch.set(messageRef, message.toFirestore());

    // 2. Update chat
    final chatRef = firestore.collection('chats').doc(message.chatId);
    batch.update(chatRef, {
      'lastMessage': message.content,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCount': FieldValue.increment(1),
    });

    await batch.commit();
  }

  @override
  Future<List<MessageModel>> getChatMessages(String chatId) async {
    final snapshot = await firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => MessageModel.fromFirestore(doc)).toList();
  }

  @override
  Stream<List<MessageModel>> streamChatMessages(String chatId) {
    return firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Future<List<ChatModel>> getUserChats(String userId) async {
    final snapshot = await firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .get();

    return snapshot.docs.map((doc) => ChatModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> markAsRead(String chatId, String userId) async {
    final batch = firestore.batch();

    // Reset unread count for chat (simplified logic)
    final chatRef = firestore.collection('chats').doc(chatId);
    batch.update(chatRef, {'unreadCount': 0});

    // Mark messages as read
    final messagesQuery = await firestore
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .where('isRead', isEqualTo: false)
        .where('senderId', isNotEqualTo: userId)
        .get();

    for (var doc in messagesQuery.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }
}
