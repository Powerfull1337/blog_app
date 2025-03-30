part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class FetchUserInformation extends ProfileEvent {}

final class UpdateUserInformation extends ProfileEvent {
  final String? name;
  final File? image;

  UpdateUserInformation({this.name, this.image});
}

