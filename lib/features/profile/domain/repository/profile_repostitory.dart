import 'dart:io';

import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, User>> getUserInformation();
  Future<Either<Failure, User>> updateUserInformation({
    required File image,
    required String name,
  });
}
