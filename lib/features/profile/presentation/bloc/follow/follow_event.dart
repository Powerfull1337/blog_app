part of 'follow_bloc.dart';

@immutable
abstract class FollowEvent {}

class CheckIfFollowing extends FollowEvent {
  final String userId;

  CheckIfFollowing(this.userId);
}

class FollowUser extends FollowEvent {
  final String userId;

  FollowUser(this.userId);
}

class UnfollowUser extends FollowEvent {
  final String userId;

  UnfollowUser(this.userId);
}
