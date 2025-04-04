
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class IsBlogLiked implements UseCase<void, IsBlogLikedParams> {
  final BlogRepository blogRepository;
  IsBlogLiked(this.blogRepository);

  @override
  Future<Either<Failure, void>> call(IsBlogLikedParams params) async {
    return await blogRepository.isBlogLiked(blogId: params.blogId, userId: params.userId);
  }
}

class IsBlogLikedParams {
  final String userId;
  final String blogId;

  IsBlogLikedParams({required this.userId, required this.blogId});
}
