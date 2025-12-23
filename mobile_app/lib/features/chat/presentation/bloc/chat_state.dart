part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class UserChatsLoaded extends ChatState {
  final List<ChatEntity> chats;
  const UserChatsLoaded(this.chats);
  @override
  List<Object?> get props => [chats];
}

class ChatMessagesLoaded extends ChatState {
  final List<MessageEntity> messages;
  const ChatMessagesLoaded(this.messages);
  @override
  List<Object?> get props => [messages];
}

class ChatCreated extends ChatState {
  final ChatEntity chat;
  const ChatCreated(this.chat);
  @override
  List<Object?> get props => [chat];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);
  @override
  List<Object?> get props => [message];
}
