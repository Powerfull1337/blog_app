part of 'like_bloc.dart';

@immutable
abstract class LikeState {}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeCountUpdated extends LikeState {
  final int count;

  LikeCountUpdated(this.count);
}

class LikeLoaded extends LikeState {
  final int count;
  final bool isLiked;

  LikeLoaded({required this.count, required this.isLiked});
}

class LikeError extends LikeState {
  final String message;

  LikeError(this.message);
}
