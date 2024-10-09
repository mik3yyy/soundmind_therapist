import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_message.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/get_user_chats.dart';

part 'get_user_chat_room_messages_state.dart';

class GetUserChatRoomMessagesCubit extends Cubit<GetUserChatRoomMessagesState> {
  final GetUserChatRoomMessages getUserChatRoomMessagesUseCase;

  GetUserChatRoomMessagesCubit({required this.getUserChatRoomMessagesUseCase})
      : super(GetUserChatRoomMessagesInitial());

  Future<void> fetchChatMessages(int chatRoomId) async {
    emit(GetUserChatRoomMessagesLoading());

    final result = await getUserChatRoomMessagesUseCase.call(chatRoomId);

    result.fold(
      (failure) => emit(GetUserChatRoomMessagesError(message: failure.message)),
      (messages) => emit(GetUserChatRoomMessagesSuccess(messages)),
    );
  }
}
