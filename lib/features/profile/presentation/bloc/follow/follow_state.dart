part of 'follow_bloc.dart';

@immutable
abstract class FollowState {}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowStatus extends FollowState {
  final bool isFollowing;

  FollowStatus({required this.isFollowing});
}

class FollowActionSuccess extends FollowState {
  final String message;

  FollowActionSuccess({required this.message});
}

class FollowError extends FollowState {
  final String message;

  FollowError(this.message);
}
