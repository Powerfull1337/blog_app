part of 'like_comment_bloc.dart';

sealed class LikeCommentState extends Equatable {
  const LikeCommentState();

  @override
  List<Object> get props => [];
}

final class LikeCommentInitial extends LikeCommentState {}

final class LikeCommentLoading extends LikeCommentState {}

final class LikeCommentLoaded extends LikeCommentState {
  final Map<String, LikeStatus> likeStatuses; // key: commentId

  const LikeCommentLoaded({required this.likeStatuses});

  @override
  List<Object> get props => [likeStatuses];
}

final class LikeCommentError extends LikeCommentState {
  final String message;

  const LikeCommentError(this.message);

  @override
  List<Object> get props => [message];
}

class LikeStatus extends Equatable {
  final bool isLikedByUser;
  final int likesCount;

  const LikeStatus({
    required this.isLikedByUser,
    required this.likesCount,
  });

  LikeStatus copyWith({
    bool? isLikedByUser,
    int? likesCount,
  }) {
    return LikeStatus(
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  @override
  List<Object> get props => [isLikedByUser, likesCount];
}
