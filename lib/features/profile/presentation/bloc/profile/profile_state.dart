part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final User user;

  ProfileLoaded(this.user);
}

final class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}
