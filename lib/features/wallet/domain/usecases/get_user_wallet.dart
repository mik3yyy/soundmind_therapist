import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/wallet/domain/repositories/wallet_repository.dart';

class GetUserWallet extends UsecaseWithoutParams<Map<String, dynamic>> {
  final WalletRepository _repository;

  GetUserWallet({required WalletRepository repository})
      : _repository = repository;

  @override
  ResultFuture<Map<String, dynamic>> call() => _repository.getUserWallet();
}
