import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repostitory.dart';
import 'package:fpdart/fpdart.dart';

class UnFollowToUser implements UseCase<void, UnFollowToUserParams> {
  final ProfileRepository profileRepository;
  UnFollowToUser(this.profileRepository);

  @override
  Future<Either<Failure, void>> call(UnFollowToUserParams params) async {
    return await profileRepository.unfollowUser(
      params.userId,
    );
  }
}

class UnFollowToUserParams {
  final String userId;

  UnFollowToUserParams({required this.userId});
}
