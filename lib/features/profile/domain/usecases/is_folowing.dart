import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class IsFollowing implements UseCase<bool, IsFollowingParams> {
  final ProfileRepository profileRepository;
  IsFollowing(this.profileRepository);

  @override
  Future<Either<Failure, bool>> call(IsFollowingParams params) async {
    return await profileRepository.isFollowing(
      params.userId,
    );
  }
}

class IsFollowingParams {
  final String userId;

  IsFollowingParams({required this.userId});
}
