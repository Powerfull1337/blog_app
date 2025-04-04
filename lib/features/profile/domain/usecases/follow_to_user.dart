import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class FollowToUser implements UseCase<void, FollowToUserParams> {
  final ProfileRepository profileRepository;
  FollowToUser(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(FollowToUserParams params) async {
    return await profileRepository.followUser(
      params.userId,
    );
  }
}

class FollowToUserParams {
  final String userId;

  FollowToUserParams({required this.userId});
}
