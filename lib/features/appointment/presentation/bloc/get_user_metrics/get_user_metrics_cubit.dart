import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/appointment/data/models/metrics_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/usecases/get_user_metrics.dart';

part 'get_user_metrics_state.dart';

class GetUserMetricsCubit extends Cubit<GetUserMetricsState> {
  final GetUserMetrics getUserMetricsUseCase;

  GetUserMetricsCubit({required this.getUserMetricsUseCase})
      : super(GetUserMetricsInitial());

  Future<void> fetchUserMetrics() async {
    emit(GetUserMetricsLoading());

    final result = await getUserMetricsUseCase.call();

    result.fold(
      (failure) => emit(GetUserMetricsError(message: failure.message)),
      (metrics) => emit(GetUserMetricsSuccess(metrics)),
    );
  }
}
