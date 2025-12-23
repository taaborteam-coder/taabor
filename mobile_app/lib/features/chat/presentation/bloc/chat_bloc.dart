import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;
  StreamSubscription? _messagesSubscription;

  ChatBloc({required this.repository}) : super(ChatInitial()) {
    on<LoadUserChats>(_onLoadUserChats);
    on<LoadChatMessages>(_onLoadChatMessages);
    on<SendMessage>(_onSendMessage);
    on<UpdateMessages>(_onUpdateMessages);
    on<CreateChat>(_onCreateChat);
  }

  Future<void> _onLoadUserChats(
    LoadUserChats event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await repository.getUserChats(event.userId);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chats) => emit(UserChatsLoaded(chats)),
    );
  }

  Future<void> _onLoadChatMessages(
    LoadChatMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    await _messagesSubscription?.cancel();
    _messagesSubscription = repository
        .streamChatMessages(event.chatId)
        .listen(
          (messages) {
            add(UpdateMessages(messages));
          },
          onError: (error) {
            // Handle stream error
          },
        );
  }

  void _onUpdateMessages(UpdateMessages event, Emitter<ChatState> emit) {
    emit(ChatMessagesLoaded(event.messages));
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    final message = MessageEntity(
      id: const Uuid().v4(),
      chatId: event.chatId,
      senderId: event.senderId,
      senderName: event.senderName, // TODO: Get name
      content: event.content,
      type: event.type,
      timestamp: DateTime.now(),
    );

    // Optimistic update could be handled here if needed,
    // but streaming updates handles it naturally.

    final result = await repository.sendMessage(message);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (_) {}, // Success handled by stream
    );
  }

  Future<void> _onCreateChat(CreateChat event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await repository.createChat(event.participants);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chat) => emit(ChatCreated(chat)),
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
