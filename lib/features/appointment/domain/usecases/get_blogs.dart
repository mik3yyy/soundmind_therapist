import 'package:sound_mind/core/utils/typedef.dart';
import 'package:sound_mind/core/usecases/usecase.dart';
import 'package:sound_mind/features/appointment/data/models/CreateBookingReq.dart';
import 'package:sound_mind/features/appointment/data/models/blog.dart';
import 'package:sound_mind/features/appointment/domain/repositories/appointment_repository.dart';

class GetBlogs extends UsecaseWithoutParams<List<Blog>> {
  final AppointmentRepository _repository;

  GetBlogs({required AppointmentRepository repository}) : _repository = repository;

  @override
  ResultFuture<List<Blog>> call() {
    return _repository.getBlogs();
  }
}
