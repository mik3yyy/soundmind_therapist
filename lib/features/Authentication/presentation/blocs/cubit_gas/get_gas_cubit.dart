import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/features/Authentication/data/models/gas.dart';
import 'package:soundmind_therapist/features/Authentication/domain/usecases/get_GAS.dart';

part 'get_gas_state.dart';

class GetGasCubit extends Cubit<GetGasState> {
  final GetGasUsecase gasUsecase;
  GetGasCubit(this.gasUsecase) : super(GetGasInitial());

  Future<void> getGas() async {
    emit(GetGasLoading());

    final result = await gasUsecase.call();

    result.fold(
      (failure) => emit(GetGasError(message: failure.message)),
      (gas) => emit(GetgasSuccess(gas: gas)),
    );
  }
}
