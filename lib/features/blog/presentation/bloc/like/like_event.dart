part of 'like_bloc.dart';

@immutable
abstract class LikeEvent {}

class LikeBlogEvent extends LikeEvent {
  final String blogId;
  final String userId;

  LikeBlogEvent({required this.blogId, required this.userId});
}

class UnlikeBlogEvent extends LikeEvent {
  final String blogId;
  final String userId;

  UnlikeBlogEvent({required this.blogId, required this.userId});
}

class FetchLikeCountEvent extends LikeEvent {
  final String blogId;

  FetchLikeCountEvent(this.blogId);
}

class FetchLikeInfo extends LikeEvent {
  final String blogId;
  final String userId;

  FetchLikeInfo({required this.blogId, required this.userId});
}
