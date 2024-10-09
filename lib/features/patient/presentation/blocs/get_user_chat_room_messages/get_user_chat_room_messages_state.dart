part of 'get_user_chat_room_messages_cubit.dart';

abstract class GetUserChatRoomMessagesState extends Equatable {
  const GetUserChatRoomMessagesState();

  @override
  List<Object> get props => [];
}

class GetUserChatRoomMessagesInitial extends GetUserChatRoomMessagesState {}

class GetUserChatRoomMessagesLoading extends GetUserChatRoomMessagesState {}

class GetUserChatRoomMessagesSuccess extends GetUserChatRoomMessagesState {
  final List<ChatMessage> messages;

  const GetUserChatRoomMessagesSuccess(this.messages);

  @override
  List<Object> get props => [messages];
}

class GetUserChatRoomMessagesError extends GetUserChatRoomMessagesState {
  final String message;

  const GetUserChatRoomMessagesError({required this.message});

  @override
  List<Object> get props => [message];
}
