part of 'like_blog_bloc.dart';

class LikeState extends Equatable {
  final bool isLiked;
  final int likesCount;

  const LikeState({
    this.isLiked = false,
    this.likesCount = 0,
  });

  LikeState copyWith({
    bool? isLiked,
    int? likesCount,
  }) {
    return LikeState(
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
    );
  }

  @override
  List<Object> get props => [isLiked, likesCount];
}

class InitializeLikeStateEvent extends LikeEvent {
  final bool isLiked;
  final int likesCount;

  const InitializeLikeStateEvent({required this.isLiked, required this.likesCount});

  @override
  List<Object?> get props => [isLiked, likesCount];
}
