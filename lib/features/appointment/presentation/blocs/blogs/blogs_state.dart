part of 'blogs_cubit.dart';

sealed class BlogsState extends Equatable {
  const BlogsState();

  @override
  List<Object> get props => [];
}

final class BlogsInitial extends BlogsState {}

class BlogsLoading extends BlogsState {}

class BlogsSuccess extends BlogsState {
  final List<Blog> blogs;

  const BlogsSuccess({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class BlogsError extends BlogsState {
  final String message;

  const BlogsError({required this.message});

  @override
  List<Object> get props => [message];
}
