part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<MessageModel> messages;
  ChatLoaded(this.messages);
}

final class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}
