


import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogLikes implements UseCase<int, GetBlogLikesParams> {
  final BlogRepository blogRepository;
  GetBlogLikes(this.blogRepository);

  @override
  Future<Either<Failure, int>> call(GetBlogLikesParams params) async {
    return await blogRepository.getBlogLikesCount(blogId: params.blogId);
  }
}

class GetBlogLikesParams {

  final String blogId;

  GetBlogLikesParams({required this.blogId});
}
