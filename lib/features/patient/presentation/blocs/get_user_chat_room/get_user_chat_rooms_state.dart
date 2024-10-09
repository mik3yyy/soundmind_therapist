part of 'get_user_chat_rooms_cubit.dart';

abstract class GetUserChatRoomsState extends Equatable {
  const GetUserChatRoomsState();

  @override
  List<Object> get props => [];
}

class GetUserChatRoomsInitial extends GetUserChatRoomsState {}

class GetUserChatRoomsLoading extends GetUserChatRoomsState {}

class GetUserChatRoomsSuccess extends GetUserChatRoomsState {
  final List<ChatRoom> chatRooms;

  const GetUserChatRoomsSuccess(this.chatRooms);

  @override
  List<Object> get props => [chatRooms];
}

class GetUserChatRoomsError extends GetUserChatRoomsState {
  final String message;

  const GetUserChatRoomsError({required this.message});

  @override
  List<Object> get props => [message];
}
