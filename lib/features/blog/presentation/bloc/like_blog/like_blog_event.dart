part of 'like_blog_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object?> get props => [];
}

class LikeBlogEvent extends LikeEvent {
  final String blogId;
  final String userId;

  const LikeBlogEvent({required this.blogId, required this.userId});

  @override
  List<Object?> get props => [blogId, userId];
}

class UnlikeBlogEvent extends LikeEvent {
  final String blogId;
  final String userId;

  const UnlikeBlogEvent({required this.blogId, required this.userId});

  @override
  List<Object?> get props => [blogId, userId];
}
class ResetLikeStateEvent extends LikeEvent {
  const ResetLikeStateEvent();
}

class CheckIfBlogLikedEvent extends LikeEvent {
  final String blogId;
  final String userId;

  const CheckIfBlogLikedEvent({required this.blogId, required this.userId});

  @override
  List<Object?> get props => [blogId, userId];
}

class GetLikesCountEvent extends LikeEvent {
  final String blogId;

  const GetLikesCountEvent({required this.blogId});

  @override
  List<Object?> get props => [blogId];
}
