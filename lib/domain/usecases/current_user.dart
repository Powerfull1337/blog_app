import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/domain/entities/user.dart';
import 'package:blog_app/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
