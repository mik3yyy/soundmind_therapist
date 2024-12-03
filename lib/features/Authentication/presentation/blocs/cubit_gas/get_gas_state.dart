part of 'get_gas_cubit.dart';

sealed class GetGasState extends Equatable {
  const GetGasState();

  @override
  List<Object> get props => [];
}

final class GetGasInitial extends GetGasState {}

final class GetGasLoading extends GetGasState {}

final class GetGasError extends GetGasState {
  final String message;

  const GetGasError({required this.message});
}

final class GetgasSuccess extends GetGasState {
  final List<GASModel> gas;

  GetgasSuccess({required this.gas});
}
