import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/domain/entities/user.dart';
import 'package:blog_app/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImplementation(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> loginwithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.loginWithEmailPassword(
          email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpwithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await authRemoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
