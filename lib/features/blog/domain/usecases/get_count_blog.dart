import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCountBlog implements UseCase<int, GetCountBlogParams> {
  final BlogRepository blogRepository;
  GetCountBlog(this.blogRepository);

  @override
  Future<Either<Failure, int>> call(GetCountBlogParams params) async {
    return await blogRepository.getCountBlog(userId: params.userId);
  }
}

class GetCountBlogParams {
  final String userId;

  GetCountBlogParams({required this.userId});
}
