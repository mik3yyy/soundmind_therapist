import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';
import 'package:soundmind_therapist/features/wallet/domain/repositories/wallet_repository.dart';

class ResolveBankAccount
    extends UsecaseWithParams<Map<String, dynamic>, ResolveBankAccountParams> {
  final WalletRepository _repository;

  ResolveBankAccount({required WalletRepository repository})
      : _repository = repository;

  @override
  ResultFuture<Map<String, dynamic>> call(ResolveBankAccountParams params) =>
      _repository.resolveBankAccount(
          accountNumber: params.accountNumber, accountBank: params.accountBank);
}

class ResolveBankAccountParams {
  final String accountNumber;
  final String accountBank;

  ResolveBankAccountParams({
    required this.accountNumber,
    required this.accountBank,
  });
}
