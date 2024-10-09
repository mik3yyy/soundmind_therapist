import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/data/models/chat_room.dart';

import 'package:soundmind_therapist/features/patient/domain/usecases/get_chat_room.dart';

part 'get_user_chat_rooms_state.dart';

class GetUserChatRoomsCubit extends Cubit<GetUserChatRoomsState> {
  final GetUserChatRooms getUserChatRoomsUseCase;

  GetUserChatRoomsCubit({required this.getUserChatRoomsUseCase})
      : super(GetUserChatRoomsInitial());

  Future<void> fetchChatRooms() async {
    emit(GetUserChatRoomsLoading());

    final result = await getUserChatRoomsUseCase.call();

    result.fold(
      (failure) => emit(GetUserChatRoomsError(message: failure.message)),
      (chatRooms) => emit(GetUserChatRoomsSuccess(chatRooms)),
    );
  }
}
