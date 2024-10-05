import 'package:soundmind_therapist/core/error/exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:soundmind_therapist/core/utils/typedef.dart';

abstract class Failure extends Equatable {
  final String message;
  final DataMap? data;

  const Failure(this.message, {this.data});

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.data});
  factory ServerFailure.fromServerException(ServerException e) {
    return ServerFailure(e.getErrorMessage);
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
  factory CacheFailure.fromCacheException(CacheException e) {
    return CacheFailure(e.getErrorMessage);
  }
}
