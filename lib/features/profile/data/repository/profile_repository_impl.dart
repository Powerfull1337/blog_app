import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, User>> getUserInformation() async {
    try {
      final user = await profileRemoteDataSource.fetchUserInformation();

      return right(user);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
