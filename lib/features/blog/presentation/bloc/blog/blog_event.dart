part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.posterId,
    required this.title,
    required this.content,
    required this.image,
    required this.topics,
  });
}

final class BlogFetchAllBlogs extends BlogEvent {}

final class BlogFetchAllBlogsById extends BlogEvent {
  final String userId;
  BlogFetchAllBlogsById({required this.userId});
}

final class BlogFetchCount extends BlogEvent {
  final String userId;
  BlogFetchCount({required this.userId});
}

final class BlogLike extends BlogEvent {
  final String blogId;
  final String userId;
  BlogLike({required this.blogId, required this.userId});
}

final class BlogUnlike extends BlogEvent {
  final String blogId;
  final String userId;
  BlogUnlike({required this.blogId, required this.userId});
}

final class BlogFetchLikesCount extends BlogEvent {
  final String blogId;
  BlogFetchLikesCount({required this.blogId});
}
