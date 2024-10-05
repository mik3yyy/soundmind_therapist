import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/wallet/domain/repositories/wallet_repository.dart';

class GetBanks extends UsecaseWithoutParams<List<Map<String, dynamic>>> {
  final WalletRepository _repository;

  GetBanks({required WalletRepository repository}) : _repository = repository;

  @override
  ResultFuture<List<Map<String, dynamic>>> call() => _repository.getBanks();
}
