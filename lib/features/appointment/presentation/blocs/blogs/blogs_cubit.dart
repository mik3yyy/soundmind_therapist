import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sound_mind/features/appointment/data/models/blog.dart';
import 'package:sound_mind/features/appointment/domain/usecases/get_blogs.dart';

part 'blogs_state.dart';

class BlogsCubit extends Cubit<BlogsState> {
  final GetBlogs getBlogs;
  BlogsCubit({required this.getBlogs}) : super(BlogsInitial());

  Future<void> getBlogsEvent() async {
    emit(BlogsLoading());
    try {
      final result = await getBlogs.call();
      print(result);
      result.fold(
        (failure) => emit(BlogsError(message: failure.message)),
        (blogs) {
          print("DATA ${blogs.length}");
          emit(BlogsSuccess(blogs: blogs));
        },
      );
    } catch (e) {
      print(e);
      emit(BlogsError(message: e.toString()));
    }
  }
}
