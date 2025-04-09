part of 'like_comment_bloc.dart';

sealed class LikeCommentEvent extends Equatable {
  const LikeCommentEvent();

  @override
  List<Object> get props => [];
}

class LoadLikeCommentStatus extends LikeCommentEvent {
  final String commentId;
  final String userId;

  const LoadLikeCommentStatus({
    required this.commentId,
    required this.userId,
  });

  @override
  List<Object> get props => [commentId, userId];
}

class LikeCommentPressed extends LikeCommentEvent {
  final String commentId;
  final String userId;

  const LikeCommentPressed({
    required this.commentId,
    required this.userId,
  });

  @override
  List<Object> get props => [commentId, userId];
}

class UnLikeCommentPressed extends LikeCommentEvent {
  final String commentId;
  final String userId;

  const UnLikeCommentPressed({
    required this.commentId,
    required this.userId,
  });

  @override
  List<Object> get props => [commentId, userId];
}
