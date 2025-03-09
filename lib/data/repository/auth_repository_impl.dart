import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, String>> loginwithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginwithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpwithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);

      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
