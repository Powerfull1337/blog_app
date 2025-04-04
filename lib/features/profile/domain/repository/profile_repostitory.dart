import 'dart:io';

import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, User>> getUserInformation();
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, User>> updateUserInformation({
    File? image,
    String? name,
    String? bio,
  });

  Future<Either<Failure,void>> followUser(String userId);
  Future<Either<Failure, void>> unfollowUser(String userId);
  Future<Either<Failure, bool>> isFollowing(String userId);
}
