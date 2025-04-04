


import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class LikeBlog implements UseCase<void, LikeBlogParams> {
  final BlogRepository blogRepository;
  LikeBlog(this.blogRepository);

  @override
  Future<Either<Failure, void>> call(LikeBlogParams params) async {
    return await blogRepository.likeBlog(blogId: params.blogId, userId: params.userId);
  }
}

class LikeBlogParams {
  final String userId;
  final String blogId;

  LikeBlogParams({required this.userId, required this.blogId});
}
