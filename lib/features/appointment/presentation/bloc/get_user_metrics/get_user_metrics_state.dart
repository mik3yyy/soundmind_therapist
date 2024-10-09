part of 'get_user_metrics_cubit.dart';

abstract class GetUserMetricsState extends Equatable {
  const GetUserMetricsState();

  @override
  List<Object> get props => [];
}

class GetUserMetricsInitial extends GetUserMetricsState {}

class GetUserMetricsLoading extends GetUserMetricsState {}

class GetUserMetricsSuccess extends GetUserMetricsState {
  final MetricsModel metrics;

  const GetUserMetricsSuccess(this.metrics);

  @override
  List<Object> get props => [metrics];
}

class GetUserMetricsError extends GetUserMetricsState {
  final String message;

  const GetUserMetricsError({required this.message});

  @override
  List<Object> get props => [message];
}
