import 'package:dartz/dartz.dart';
import 'package:soundmind_therapist/core/error/failures.dart';
import 'package:soundmind_therapist/core/usecases/usecase.dart';
import 'package:soundmind_therapist/features/appointment/data/models/metrics_model.dart';
import 'package:soundmind_therapist/features/appointment/domain/repositories/appointment_repository.dart';

class GetUserMetrics extends UsecaseWithoutParams<MetricsModel> {
  final AppointmentRepository repository;

  GetUserMetrics({required this.repository});

  @override
  Future<Either<Failure, MetricsModel>> call() {
    return repository.getUserMetrics();
  }
}
