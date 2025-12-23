part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserChats extends ChatEvent {
  final String userId;
  const LoadUserChats(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadChatMessages extends ChatEvent {
  final String chatId;
  const LoadChatMessages(this.chatId);
  @override
  List<Object?> get props => [chatId];
}

class UpdateMessages extends ChatEvent {
  final List<MessageEntity> messages;
  const UpdateMessages(this.messages);
  @override
  List<Object?> get props => [messages];
}

class SendMessage extends ChatEvent {
  final String chatId;
  final String senderId;
  final String senderName;
  final String content;
  final MessageType type;

  const SendMessage({
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.content,
    this.type = MessageType.text,
  });

  @override
  List<Object?> get props => [chatId, senderId, senderName, content, type];
}

class CreateChat extends ChatEvent {
  final List<String> participants;
  const CreateChat(this.participants);
  @override
  List<Object?> get props => [participants];
}
