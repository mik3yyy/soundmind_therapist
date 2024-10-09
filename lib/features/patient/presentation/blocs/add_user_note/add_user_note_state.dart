part of 'add_user_note_cubit.dart';

abstract class AddUserNoteState extends Equatable {
  const AddUserNoteState();

  @override
  List<Object> get props => [];
}

class AddUserNoteInitial extends AddUserNoteState {}

class AddUserNoteLoading extends AddUserNoteState {}

class AddUserNoteSuccess extends AddUserNoteState {}

class AddUserNoteError extends AddUserNoteState {
  final String message;

  const AddUserNoteError({required this.message});

  @override
  List<Object> get props => [message];
}
