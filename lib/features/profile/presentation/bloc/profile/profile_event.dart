part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class FetchUserInformation extends ProfileEvent {}

final class UpdateUserInformation extends ProfileEvent {
  final String? name;
  final File? image;
  final String? bio;

  UpdateUserInformation({this.name, this.image, this.bio});
}

final class FetchAllUsers extends ProfileEvent {}