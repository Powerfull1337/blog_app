import 'package:blog_app/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpwithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> loginwithEmailAndPassword({
    required String email,
    required String password,
  });
}
