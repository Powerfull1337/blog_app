import 'package:blog_app/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpwithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginwithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
