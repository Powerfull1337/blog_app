import 'dart:io';

import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class UpdateUserInfo implements UseCase<User, UpdateUserInfoParams> {
  final ProfileRepository profileRepository;
  UpdateUserInfo(this.profileRepository);

  @override
  Future<Either<Failure, User>> call(UpdateUserInfoParams params) async {
    return await profileRepository.updateUserInformation(
      image: params.image,
      name: params.name,
    );
  }
}

class UpdateUserInfoParams {
  final String? name;
  final File? image;

  UpdateUserInfoParams({this.name, this.image});
}
