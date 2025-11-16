import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_mind/features/appointment/domain/usecases/create_booking.dart';

part 'booking_state.dart';

class CreateBookingCubit extends Cubit<CreateBookingState> {
  final CreateBooking createBooking;
  final RescheduleBooking rescheduleBooking;

  CreateBookingCubit({required this.createBooking, required this.rescheduleBooking}) : super(CreateBookingInitial());

  Future<void> createBookingEvent(CreateBookingParams params) async {
    emit(CreateBookingLoading());

    final result = await createBooking.call(params);
    result.fold(
      (failure) => emit(CreateBookingError(message: failure.message)),
      (_) => emit(CreateBookingSuccess()),
    );
  }

  Future<void> rescheuleBookingEvent(CreateBookingParams params) async {
    emit(CreateBookingLoading());

    final result = await rescheduleBooking.call(params);
    result.fold(
      (failure) => emit(CreateBookingError(message: failure.message)),
      (_) => emit(CreateBookingSuccess()),
    );
  }
}
