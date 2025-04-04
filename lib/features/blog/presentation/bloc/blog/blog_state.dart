part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogUploadSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  final int? blogCount;
  final int? likesCount;

  BlogLoaded({required this.blogs, this.blogCount, this.likesCount});

  BlogLoaded copyWith({
    List<Blog>? blogs,
    int? blogCount,
    int? likesCount,
  }) {
    return BlogLoaded(
      blogs: blogs ?? this.blogs,
      blogCount: blogCount ?? this.blogCount,
      likesCount: likesCount ?? this.likesCount,
    );
  }
}
