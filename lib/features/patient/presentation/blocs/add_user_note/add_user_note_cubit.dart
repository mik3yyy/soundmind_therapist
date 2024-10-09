import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/patient/domain/usecases/add_user_note.dart';

part 'add_user_note_state.dart';

class AddUserNoteCubit extends Cubit<AddUserNoteState> {
  final AddUserNote addUserNoteUseCase;

  AddUserNoteCubit({required this.addUserNoteUseCase})
      : super(AddUserNoteInitial());

  Future<void> addNote({
    required int patientId,
    required String note,
  }) async {
    emit(AddUserNoteLoading());

    final result = await addUserNoteUseCase.call(
      AddUserNoteParams(patientId: patientId, note: note),
    );

    result.fold(
      (failure) => emit(AddUserNoteError(message: failure.message)),
      (_) => emit(AddUserNoteSuccess()),
    );
  }
}
