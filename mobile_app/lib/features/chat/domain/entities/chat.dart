import 'package:equatable/equatable.dart';

enum MessageType { text, image, file }

class MessageEntity extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String senderName;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isRead;
  final String? imageUrl;
  final String? fileUrl;

  const MessageEntity({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.imageUrl,
    this.fileUrl,
  });

  @override
  List<Object?> get props => [
    id,
    chatId,
    senderId,
    senderName,
    content,
    type,
    timestamp,
    isRead,
    imageUrl,
    fileUrl,
  ];
}

class ChatEntity extends Equatable {
  final String id;
  final List<String> participants;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  const ChatEntity({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });

  @override
  List<Object?> get props => [
    id,
    participants,
    lastMessage,
    lastMessageTime,
    unreadCount,
  ];
}
