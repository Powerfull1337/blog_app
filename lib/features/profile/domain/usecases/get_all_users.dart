


import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class GetAllUsers implements UseCase<List<User>, NoParams> {
  final ProfileRepository profileRepostitory;

  GetAllUsers(this.profileRepostitory);

  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await profileRepostitory.getAllUsers();
  }
}
